#!/bin/bash
# Baixa o APK Android que o CI do mehah/otclient gerou para o mesmo commit do otc/,
# e guarda em D:/crandoria/otc-oficial/. Rodar no Git Bash do Windows (usa o gh logado).
#
# Por que: o libotclient.so que compilamos no WSL fecha sozinho logo no
# Application::init (02/10/2026, Galaxy A14 / Android 15), e o do CI oficial, do
# mesmo commit, funciona. O build.sh troca a lib pela oficial. Os artefatos do CI
# expiram em 14 dias, entao baixar logo depois de atualizar o subtree.
set -euo pipefail
cd "$(dirname "$0")/../.."
SHA=$(git log --grep="git-subtree-dir: otc" -1 --format=%B | grep -oE "git-subtree-split: [0-9a-f]{40}" | cut -d' ' -f2)
DEST=/d/crandoria/otc-oficial/otclient-android-$SHA.apk
[ -f "$DEST" ] && { echo "ja existe: $DEST"; exit 0; }
NOME="otclient-android-release-$SHA"
ID=$(gh api "repos/mehah/otclient/actions/artifacts?name=$NOME&per_page=5" -q '.artifacts[] | select(.expired==false) | .id' | head -1)
[ -n "$ID" ] || { echo "artefato $NOME nao encontrado ou expirado no CI do mehah"; exit 1; }
TMP=$(mktemp -d)
gh api "repos/mehah/otclient/actions/artifacts/$ID/zip" > "$TMP/a.zip"
python -c "import zipfile,sys; zipfile.ZipFile(sys.argv[1]).extract('app-release.apk', sys.argv[2])" "$TMP/a.zip" "$TMP"
mkdir -p "$(dirname "$DEST")"
mv "$TMP/app-release.apk" "$DEST"
rm -rf "$TMP"
echo "salvo: $DEST"
