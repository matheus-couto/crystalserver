#!/usr/bin/env python3
"""
Agente privilegiado do painel.

Existe por um motivo so: o painel precisa reiniciar containers e ler logs,
mas dar o socket do Docker para ele seria entregar a maquina inteira. O
socket do Docker nao tem meio termo - quem fala com ele pode criar um
container privilegiado montando a raiz do host, o que e root sem senha.

Entao o painel nao fala com o Docker. Ele fala com este agente por um socket
unix, e o agente aceita uma lista fechada de verbos, sobre uma lista fechada
de servicos. Se o painel for comprometido, o atacante consegue o que o
painel ja fazia - reiniciar o servidor, ler log - e nada alem disso.

Roda como servico do systemd, fora do Docker.
"""

import grp
import json
import os
import re
import shutil
import socket
import socketserver
import subprocess
import sys
import tempfile
import threading
import time

SOCKET_PATH = "/run/crandoria-painel/agent.sock"
SOCKET_GROUP = "painel"
COMPOSE_DIR = "/opt/crandoria/docker"

# Nada fora desta lista e tocado, nem que o pedido peca. Os nomes sao os do
# compose, nao os do container, porque e assim que o docker compose os
# enderece.
SERVICES = ("server", "myacc", "database", "caddy", "donate")

# Verbos que mudam estado. Separados para o log distinguir leitura de acao.
WRITE_VERBS = ("restart", "stop", "start", "config_gravar")

MAX_REQUEST = 12 * 1024 * 1024
MAX_LINES = 2000
TIMEOUT = 180


def run(args, timeout=TIMEOUT):
    """Executa sem shell: a lista vai direto para o execve, entao nao ha
    interpretacao de aspas, pipe ou ponto-e-virgula para escapar."""
    try:
        p = subprocess.run(
            args, cwd=COMPOSE_DIR, capture_output=True, text=True,
            timeout=timeout, shell=False,
        )
        return p.returncode, p.stdout, p.stderr
    except subprocess.TimeoutExpired:
        return 124, "", "tempo esgotado"
    except Exception as exc:
        return 1, "", str(exc)


def compose(*args):
    return run(["docker", "compose", "-f", "docker-compose.yml",
                "-f", "docker-compose.prod.yml"] + list(args))


def check_service(name):
    if name not in SERVICES:
        raise ValueError("servico nao permitido: %r" % name)
    return name


# ---------------------------------------------------------------- verbos

def v_status(_req):
    """Estado de cada container, em uma forma que o painel so precisa exibir."""
    code, out, err = run([
        "docker", "ps", "-a", "--format",
        "{{.Names}}\t{{.State}}\t{{.Status}}\t{{.RunningFor}}",
    ])
    if code != 0:
        return {"ok": False, "erro": err.strip()}

    linhas = []
    for linha in out.strip().splitlines():
        partes = linha.split("\t")
        if len(partes) >= 4 and partes[0].startswith("crystalserver-"):
            linhas.append({
                "nome": partes[0],
                "servico": partes[0].replace("crystalserver-", "").rsplit("-", 1)[0],
                "estado": partes[1],
                "status": partes[2],
                "desde": partes[3],
            })
    return {"ok": True, "containers": linhas}


def v_stats(_req):
    """Uso por container. --no-stream tira uma foto e sai, em vez de
    transmitir continuamente."""
    code, out, err = run([
        "docker", "stats", "--no-stream", "--format",
        "{{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.MemPerc}}\t{{.NetIO}}",
    ], timeout=30)
    if code != 0:
        return {"ok": False, "erro": err.strip()}

    linhas = []
    for linha in out.strip().splitlines():
        p = linha.split("\t")
        if len(p) >= 5:
            linhas.append({"nome": p[0], "cpu": p[1], "mem": p[2],
                           "mem_pct": p[3], "rede": p[4]})
    return {"ok": True, "containers": linhas}


def v_host(_req):
    """Recursos da maquina, lidos do /proc para nao depender de ferramenta
    instalada."""
    dados = {}
    try:
        with open("/proc/loadavg") as f:
            partes = f.read().split()
        dados["carga"] = [float(x) for x in partes[:3]]
        dados["cpus"] = os.cpu_count() or 1
    except Exception:
        pass

    try:
        mem = {}
        with open("/proc/meminfo") as f:
            for linha in f:
                chave, _, resto = linha.partition(":")
                mem[chave] = int(resto.split()[0])  # kB
        total = mem.get("MemTotal", 0)
        disp = mem.get("MemAvailable", 0)
        dados["mem_total_mb"] = total // 1024
        dados["mem_usada_mb"] = (total - disp) // 1024
        dados["mem_pct"] = round((total - disp) * 100.0 / total, 1) if total else 0
    except Exception:
        pass

    try:
        u = shutil.disk_usage("/")
        dados["disco_total_gb"] = round(u.total / 2**30, 1)
        dados["disco_usado_gb"] = round(u.used / 2**30, 1)
        dados["disco_pct"] = round(u.used * 100.0 / u.total, 1)
    except Exception:
        pass

    try:
        with open("/proc/uptime") as f:
            dados["uptime_s"] = int(float(f.read().split()[0]))
    except Exception:
        pass

    return {"ok": True, "host": dados}


# Sequencias de escape ANSI - cor, negrito, movimento de cursor. No terminal
# viram formatacao; no navegador chegam como "B[31mB[1merrorB[m". O
# `--no-color` do compose nao resolve: ele so tira a cor do prefixo que o
# proprio compose escreve, enquanto o servidor de jogo emite as suas dentro
# da linha.
ANSI = re.compile("\x1b\\[[0-9;?]*[a-zA-Z]|\x1b[@-Z\\\\-_]|[\x00-\x08\x0b\x0c\x0e-\x1f]")


def limpar_ansi(texto):
    return ANSI.sub("", texto or "")


def v_logs(req):
    servico = check_service(req.get("servico", "server"))
    linhas = req.get("linhas", 200)
    if not isinstance(linhas, int) or not (1 <= linhas <= MAX_LINES):
        linhas = 200

    code, out, err = compose("logs", "--no-color", "--tail", str(linhas), servico)
    # O compose escreve parte do log em stderr; juntar os dois e o que da a
    # visao completa.
    texto = (out or "") + (err or "") if code == 0 else (err or out or "")
    return {"ok": code == 0, "texto": limpar_ansi(texto)[-600000:]}


def v_restart(req):
    servico = check_service(req.get("servico", "server"))
    code, out, err = compose("restart", servico)
    return {"ok": code == 0, "saida": (out + err).strip()}


def v_stop(req):
    servico = check_service(req.get("servico", "server"))
    code, out, err = compose("stop", servico)
    return {"ok": code == 0, "saida": (out + err).strip()}


def v_start(req):
    servico = check_service(req.get("servico", "server"))
    code, out, err = compose("start", servico)
    return {"ok": code == 0, "saida": (out + err).strip()}


def v_luacheck(req):
    """Compila um Lua e devolve o erro, sem executar nada.

    `luajit -b entrada /dev/null` roda so o parser: gera o bytecode e joga
    fora. Codigo de topo de arquivo nao e executado, entao validar um script
    enviado pelo painel nao e um caminho para execucao.

    O codigo vem no proprio pedido, e nao como caminho de arquivo: o painel
    roda em container e o agente no host, entao /tmp de um nao e /tmp do
    outro. Antes disso a validacao recusava tudo com "arquivo nao
    encontrado", inclusive Lua correto.
    """
    conteudo = req.get("conteudo")
    if not isinstance(conteudo, str):
        raise ValueError("conteudo ausente")
    if len(conteudo) > 8 * 1024 * 1024:
        raise ValueError("conteudo grande demais")

    fd, caminho = tempfile.mkstemp(prefix="painel-luacheck-", suffix=".lua")
    try:
        with os.fdopen(fd, "w", encoding="utf-8") as f:
            f.write(conteudo)
        code, out, err = run(["luajit", "-b", caminho, "/dev/null"], timeout=20)
        # A mensagem do luajit carrega o caminho temporario, que nao diz nada
        # para quem esta no navegador.
        msg = (err or out).strip().replace(caminho, "arquivo")
        return {"ok": code == 0, "erro": msg}
    finally:
        try:
            os.unlink(caminho)
        except OSError:
            pass


def v_dump(req):
    """Dump do banco para um arquivo, que o painel depois serve para download."""
    destino = req.get("destino", "")
    if not isinstance(destino, str) or not destino.startswith("/opt/crandoria/backups/"):
        raise ValueError("destino fora da pasta de backups")
    if not re.fullmatch(r"[A-Za-z0-9._/-]+\.sql\.gz", destino):
        raise ValueError("nome de arquivo invalido")

    os.makedirs(os.path.dirname(destino), exist_ok=True)
    env = {}
    try:
        with open(os.path.join(COMPOSE_DIR, ".env")) as f:
            for linha in f:
                if "=" in linha and not linha.strip().startswith("#"):
                    k, _, v = linha.strip().partition("=")
                    env[k] = v
    except Exception as exc:
        return {"ok": False, "erro": "nao consegui ler o .env: %s" % exc}

    senha = env.get("MYSQL_ROOT_PASSWORD", "")
    banco = env.get("MYSQL_DATABASE", "crandoria")
    # A senha vai por variavel de ambiente do mariadb-dump, nao na linha de
    # comando, para nao aparecer no ps de quem estiver na maquina.
    proc = subprocess.Popen(
        ["docker", "exec", "-e", "MYSQL_PWD=" + senha, "crystalserver-database-1",
         "mariadb-dump", "-uroot", "--single-transaction", "--quick", banco],
        stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=COMPOSE_DIR,
    )
    try:
        import gzip
        with gzip.open(destino, "wb", compresslevel=6) as saida:
            shutil.copyfileobj(proc.stdout, saida)
        proc.stdout.close()
        proc.wait(timeout=600)
    except Exception as exc:
        proc.kill()
        return {"ok": False, "erro": str(exc)}

    if proc.returncode != 0:
        erro = proc.stderr.read().decode("utf-8", "replace")
        try:
            os.unlink(destino)
        except OSError:
            pass
        return {"ok": False, "erro": erro.strip()[:2000]}

    return {"ok": True, "arquivo": destino, "bytes": os.path.getsize(destino)}


# O config.lua fica fora das montagens do painel de proposito: montar um
# arquivo avulso prende o container ao inode, e um `sed -i` no host troca o
# inode - o painel passaria a mostrar e gravar uma versao que o servidor nao
# le mais. Pelo agente o caminho e fixo e nao vem do pedido.
CONFIG_PATH = "/opt/crandoria/config.lua"
CONFIG_BACKUP_DIR = "/opt/crandoria/backups/scripts/config"


def v_config_ler(_req):
    st = os.stat(CONFIG_PATH)
    with open(CONFIG_PATH, encoding="utf-8", errors="replace") as f:
        texto = f.read()
    return {"ok": True, "texto": texto, "tamanho": st.st_size,
            "mtime": int(st.st_mtime * 1000)}


def v_config_gravar(req):
    conteudo = req.get("conteudo")
    if not isinstance(conteudo, str):
        raise ValueError("conteudo ausente")
    if len(conteudo) > 4 * 1024 * 1024:
        raise ValueError("conteudo grande demais")

    # Um config.lua quebrado impede o boot do servidor inteiro.
    check = v_luacheck({"conteudo": conteudo})
    if not check["ok"]:
        return {"ok": False, "erro": check["erro"], "sintaxe": True}

    try:
        gid = grp.getgrnam(SOCKET_GROUP).gr_gid
    except KeyError:
        gid = 0

    # Mesmo nome e formato de carimbo dos backups do painel, para o
    # historico e a poda de la enxergarem estes tambem.
    os.makedirs(CONFIG_BACKUP_DIR, exist_ok=True)
    os.chown(CONFIG_BACKUP_DIR, 0, gid)
    os.chmod(CONFIG_BACKUP_DIR, 0o2770)
    carimbo = time.strftime("%Y-%m-%dT%H-%M-%S-000Z", time.gmtime())
    backup = os.path.join(CONFIG_BACKUP_DIR, "config.lua." + carimbo)
    shutil.copy2(CONFIG_PATH, backup)
    os.chown(backup, 0, gid)
    os.chmod(backup, 0o660)

    st = os.stat(CONFIG_PATH)
    tmp = CONFIG_PATH + ".painel-tmp"
    try:
        with open(tmp, "w", encoding="utf-8", newline="") as f:
            f.write(conteudo)
        os.chown(tmp, st.st_uid, st.st_gid)
        os.chmod(tmp, st.st_mode & 0o7777)
        os.replace(tmp, CONFIG_PATH)
    except OSError as exc:
        # Sem isto o erro virava "falha interna do agente", que nao diz nada.
        # O caso comum e EROFS: o ProtectSystem do unit nao libera a pasta.
        for p in (tmp, backup):
            try:
                os.unlink(p)
            except OSError:
                pass
        log("config.lua nao gravado: %r" % exc)
        return {"ok": False, "erro": "nao consegui gravar %s: %s" % (CONFIG_PATH, exc.strerror or exc)}
    log("config.lua gravado pelo painel (%d bytes); anterior em %s" % (len(conteudo.encode("utf-8")), backup))
    return {"ok": True, "backup": backup, "bytes": len(conteudo.encode("utf-8"))}


VERBOS = {
    "status": v_status,
    "stats": v_stats,
    "host": v_host,
    "logs": v_logs,
    "restart": v_restart,
    "stop": v_stop,
    "start": v_start,
    "luacheck": v_luacheck,
    "dump": v_dump,
    "config_ler": v_config_ler,
    "config_gravar": v_config_gravar,
}


class Handler(socketserver.StreamRequestHandler):
    timeout = TIMEOUT + 30

    def handle(self):
        try:
            bruto = self.rfile.readline(MAX_REQUEST)
            if not bruto:
                return
            req = json.loads(bruto.decode("utf-8"))
            verbo = req.get("verbo")
            fn = VERBOS.get(verbo)
            if fn is None:
                resp = {"ok": False, "erro": "verbo desconhecido"}
            else:
                inicio = time.time()
                resp = fn(req)
                if verbo in WRITE_VERBS:
                    log("acao %s %s -> %s (%.1fs)" % (
                        verbo, req.get("servico", "-"),
                        "ok" if resp.get("ok") else "falhou",
                        time.time() - inicio))
        except ValueError as exc:
            resp = {"ok": False, "erro": str(exc)}
        except Exception as exc:
            log("erro inesperado: %r" % exc)
            resp = {"ok": False, "erro": "falha interna do agente"}

        try:
            self.wfile.write((json.dumps(resp) + "\n").encode("utf-8"))
        except Exception:
            pass


class Server(socketserver.ThreadingUnixStreamServer):
    daemon_threads = True
    allow_reuse_address = True


def log(msg):
    sys.stderr.write("%s %s\n" % (time.strftime("%Y-%m-%d %H:%M:%S"), msg))
    sys.stderr.flush()


def main():
    pasta = os.path.dirname(SOCKET_PATH)
    os.makedirs(pasta, exist_ok=True)
    if os.path.exists(SOCKET_PATH):
        os.unlink(SOCKET_PATH)

    srv = Server(SOCKET_PATH, Handler)

    # Só o grupo do painel enxerga o socket. Sem isso qualquer usuario da
    # maquina poderia mandar "restart".
    try:
        gid = grp.getgrnam(SOCKET_GROUP).gr_gid
        os.chown(SOCKET_PATH, 0, gid)
        os.chmod(SOCKET_PATH, 0o660)
        os.chown(pasta, 0, gid)
        os.chmod(pasta, 0o750)
    except KeyError:
        log("AVISO: grupo %s nao existe; socket fica so para o root" % SOCKET_GROUP)
        os.chmod(SOCKET_PATH, 0o600)

    log("agente ouvindo em %s (verbos: %s)" % (SOCKET_PATH, ", ".join(sorted(VERBOS))))
    try:
        srv.serve_forever()
    except KeyboardInterrupt:
        pass
    finally:
        srv.server_close()
        if os.path.exists(SOCKET_PATH):
            os.unlink(SOCKET_PATH)


if __name__ == "__main__":
    main()
