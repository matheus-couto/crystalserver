# Instalador do cliente CrandoriaOT

Gera um unico `CrandoriaOT-Setup.exe` com o cliente inteiro dentro, para o
jogador baixar de qualquer lugar (Drive, Mega, site) sem depender do servidor
do jogo ficar servindo 380 MB por download.

## Como funciona

O pacote do cliente e um `.zip` **concatenado no fim** do executavel, nao um
recurso do PyInstaller. O `zipfile` do Python localiza o indice a partir do
fim do arquivo e desconta o prefixo sozinho, que e como todo SFX funciona.

Vale o incomodo: com `--add-data`, o PyInstaller extrairia os 368 MB para a
pasta temporaria a cada execucao, antes da janela aparecer. Do jeito atual o
instalador abre na hora e le direto de si mesmo.

## Montar

    pip install pyinstaller
    python build.py

Le `../../client/`, escreve `../../../CrandoriaOT-Setup.exe`. Para mudar:

    python build.py --client D:\outro\client --out D:\saida\Setup.exe

O build falha de proposito se o `client.exe` empacotado ainda apontar para
`127.0.0.1` em vez de `crandoriaot.com.br` — sem isso os jogadores baixariam
um cliente que nao loga em lugar nenhum.

Ficam de fora do pacote: `*.bak`, e as pastas `cache`, `crashdump`, `log`,
`characterdata` e `minimap`, que sao estado da maquina de quem empacotou.

## O que o instalador faz

- pergunta a pasta (padrao `%LOCALAPPDATA%\Programs\CrandoriaOT`)
- extrai com barra de progresso
- cria atalho na area de trabalho e no menu iniciar, opcionais
- grava `desinstalar.bat` e registra em Adicionar/Remover Programas
- oferece "Jogar agora" no fim

Tudo por usuario (`HKCU`, `%LOCALAPPDATA%`), entao nao pede administrador.

## Ao atualizar o cliente

Rode `build.py` de novo e suba o novo `.exe`. Nao ha atualizador incremental:
quem ja instalou reinstala por cima, na mesma pasta.
