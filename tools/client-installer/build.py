#!/usr/bin/env python3
"""
Monta o CrandoriaOT-Setup.exe.

Tres passos:
  1. compacta a pasta do cliente num .zip
  2. compila o installer.py num .exe pequeno com o PyInstaller
  3. concatena o .zip no fim do .exe

O passo 3 e o que evita o PyInstaller --add-data: embutido por la, os 368 MB
seriam extraidos para a pasta temporaria a cada execucao, antes da tela
aparecer. Concatenado, o zipfile le direto do proprio executavel.

Uso:
    python build.py [--client <dir>] [--out <arquivo.exe>]
    python build.py --otc            # OTClient Redemption de otc/

Com --otc o pacote leva so o que o OTClient le em tempo de execucao (o
otc/ tambem tem o codigo-fonte, o build e o .pdb de 350 MB) e um
installer.json que faz o instalador usar outro nome e o otclient.exe.
"""

import argparse
import json
import os
import shutil
import subprocess
import sys
import tempfile
import time
import zipfile

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.abspath(os.path.join(HERE, "..", ".."))

# Nao vao para o jogador:
#   .bak     copia do binario antes do patch da URL de login
#   cache    dados de sessao da maquina de quem empacotou
#   log, crashdump, characterdata, minimap  idem
SKIP_SUFFIX = (".bak",)
SKIP_DIRS = {"cache", "crashdump", "log", "characterdata", "minimap"}

# OTClient: o que vai para o jogador. O resto do otc/ e fonte e build.
OTC_INCLUDE = ["otclient.exe", "init.lua", "otclientrc.lua", "config.ini",
               "cacert.pem", "data", "modules", "mods"]
OTC_SKIP_SUFFIX = (".log", ".pdb")
# Sem o SKIP_DIRS do oficial: la "minimap" e cache do jogador, aqui
# data/images/game/minimap sao as imagens da interface.
OTC_SKIP_DIRS = set()
OTC_VARIANT = {"app_name": "CrandoriaOT OTC", "exe": "otclient.exe"}


def pack(client_dir, zip_path, include=None, skip_suffix=SKIP_SUFFIX, skip_dirs=SKIP_DIRS, variant=None):
    files = []
    total = 0
    roots = [os.path.join(client_dir, i) for i in include] if include else [client_dir]
    for top in roots:
        if os.path.isfile(top):
            files.append(top)
            total += os.path.getsize(top)
            continue
        if not os.path.isdir(top):
            raise RuntimeError("faltando no cliente: %s" % top)
        for root, dirs, names in os.walk(top):
            dirs[:] = [d for d in dirs if d.lower() not in skip_dirs]
            for n in names:
                if n.endswith(skip_suffix):
                    continue
                p = os.path.join(root, n)
                files.append(p)
                total += os.path.getsize(p)

    print("  %d arquivos, %.0f MB crus" % (len(files), total / 1048576))
    t0 = time.time()
    with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED, compresslevel=6) as z:
        for p in files:
            z.write(p, os.path.relpath(p, client_dir))
        if variant:
            z.writestr("installer.json", json.dumps(variant))
    print("  compactado: %.0f MB em %.0fs"
          % (os.path.getsize(zip_path) / 1048576, time.time() - t0))


def build_stub(work, dist):
    cmd = [
        sys.executable, "-m", "PyInstaller",
        "--noconfirm", "--clean", "--onefile", "--windowed",
        "--name", "CrandoriaOT-Setup",
        "--distpath", dist, "--workpath", os.path.join(work, "build"),
        "--specpath", work,
        os.path.join(HERE, "installer.py"),
    ]
    subprocess.run(cmd, check=True, capture_output=True)
    stub = os.path.join(dist, "CrandoriaOT-Setup.exe")
    print("  stub: %.1f MB" % (os.path.getsize(stub) / 1048576))
    return stub


def verify(exe):
    """Le o pacote de volta pelo proprio exe, como o instalador fara."""
    with zipfile.ZipFile(exe) as z:
        names = z.namelist()
        if not any(n.endswith("bin/client.exe") for n in names):
            raise RuntimeError("bin/client.exe nao esta no pacote")
        data = z.read("bin/client.exe")

    novo = data.count(b"https://crandoriaot.com.br/login.php")
    velho = data.count(b"http://127.0.0.1/login.php")
    print("  arquivos no pacote: %d" % len(names))
    print("  URL do servidor: %d ocorrencia(s)   URL local: %d" % (novo, velho))
    if velho or not novo:
        raise RuntimeError(
            "o client.exe ainda aponta para 127.0.0.1 - rode o patch da URL "
            "antes de empacotar, ou os jogadores nao conseguirao logar")


def verify_otc(exe):
    """O pacote do OTClient precisa abrir no Crandoria sem nada a mais."""
    with zipfile.ZipFile(exe) as z:
        names = set(z.namelist())
        init = z.read("init.lua").decode("utf-8", "replace")
    print("  arquivos no pacote: %d" % len(names))
    faltando = [n for n in ("otclient.exe", "installer.json",
                            "data/things/1525/catalog-content.json",
                            "data/sounds/1525/catalog-sound.json",
                            "data/images/game/minimap/floor_up.png") if n not in names]
    if faltando:
        raise RuntimeError("faltando no pacote: %s" % ", ".join(faltando))
    if not any(n.startswith("data/things/1525/appearances-") for n in names):
        raise RuntimeError("appearances do 15.25 nao esta no pacote")
    if "crandoriaot.com.br/login.php" not in init or "protocol = 1525" not in init:
        raise RuntimeError("init.lua nao aponta para o CrandoriaOT 15.25")
    print("  init.lua: crandoriaot.com.br, protocolo 1525")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--otc", action="store_true",
                    help="empacota o OTClient de otc/ em vez do cliente oficial")
    ap.add_argument("--client")
    ap.add_argument("--out")
    args = ap.parse_args()
    if args.otc:
        args.client = args.client or os.path.join(REPO, "otc")
        args.out = args.out or os.path.join(os.path.dirname(REPO), "CrandoriaOT-OTC-Setup.exe")
    else:
        args.client = args.client or os.path.join(REPO, "client")
        args.out = args.out or os.path.join(os.path.dirname(REPO), "CrandoriaOT-Setup.exe")

    if not os.path.isdir(args.client):
        sys.exit("pasta do cliente nao encontrada: %s" % args.client)

    work = tempfile.mkdtemp(prefix="crandoria-setup-")
    try:
        print("1) compactando o cliente")
        zip_path = os.path.join(work, "payload.zip")
        if args.otc:
            pack(args.client, zip_path, include=OTC_INCLUDE,
                 skip_suffix=OTC_SKIP_SUFFIX, skip_dirs=OTC_SKIP_DIRS, variant=OTC_VARIANT)
        else:
            pack(args.client, zip_path)

        print("2) compilando o instalador")
        stub = build_stub(work, os.path.join(work, "dist"))

        print("3) anexando o pacote")
        with open(args.out, "wb") as out:
            with open(stub, "rb") as f:
                shutil.copyfileobj(f, out)
            with open(zip_path, "rb") as f:
                shutil.copyfileobj(f, out)

        print("4) conferindo")
        (verify_otc if args.otc else verify)(args.out)

        print("\npronto: %s  (%.0f MB)"
              % (args.out, os.path.getsize(args.out) / 1048576))
    finally:
        shutil.rmtree(work, ignore_errors=True)


if __name__ == "__main__":
    main()
