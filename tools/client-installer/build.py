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
"""

import argparse
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


def pack(client_dir, zip_path):
    files = []
    total = 0
    for root, dirs, names in os.walk(client_dir):
        dirs[:] = [d for d in dirs if d.lower() not in SKIP_DIRS]
        for n in names:
            if n.endswith(SKIP_SUFFIX):
                continue
            p = os.path.join(root, n)
            files.append(p)
            total += os.path.getsize(p)

    print("  %d arquivos, %.0f MB crus" % (len(files), total / 1048576))
    t0 = time.time()
    with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED, compresslevel=6) as z:
        for p in files:
            z.write(p, os.path.relpath(p, client_dir))
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


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--client", default=os.path.join(REPO, "client"))
    ap.add_argument("--out", default=os.path.join(
        os.path.dirname(REPO), "CrandoriaOT-Setup.exe"))
    args = ap.parse_args()

    if not os.path.isdir(args.client):
        sys.exit("pasta do cliente nao encontrada: %s" % args.client)

    work = tempfile.mkdtemp(prefix="crandoria-setup-")
    try:
        print("1) compactando o cliente")
        zip_path = os.path.join(work, "payload.zip")
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
        verify(args.out)

        print("\npronto: %s  (%.0f MB)"
              % (args.out, os.path.getsize(args.out) / 1048576))
    finally:
        shutil.rmtree(work, ignore_errors=True)


if __name__ == "__main__":
    main()
