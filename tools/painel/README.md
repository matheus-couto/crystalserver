# Painel de administracao

`https://painel.crandoriaot.com.br`

Cobre o lado de **operacao** do servidor de jogo: status, logs, recursos,
reiniciar, editar script, itens, doacoes e backup. A parte de **conta e
jogador** continua no admin do MyAAC (`/admin/`), que ja faz isso bem.

## O desenho, e por que ele e assim

Um painel que reinicia o servidor e grava script Lua e, por definicao,
execucao remota de codigo. O SSH desta maquina ja leva umas 18 tentativas de
invasao por dia, entao a pergunta nao e "sera que tentam", e sim "ate onde
chega quem conseguir".

Tres barreiras, nessa ordem:

**1. O painel nao tem acesso ao Docker.** Dar o socket do Docker a ele seria
entregar a maquina: com esse socket da para criar um container privilegiado
montando a raiz do host, o que e root sem senha. Em vez disso existe o
`agent.py`, um servico do systemd que escuta num socket unix e so aceita
nove verbos, sobre cinco servicos nomeados. Pedido fora da lista e recusado
antes de virar comando — inclusive `{"verbo":"restart","servico":"../../etc"}`
e `{"verbo":"dump","destino":"/etc/cron.d/x.sql.gz"}`, que foram testados.

**2. O container so enxerga o que precisa.** As montagens sao estreitas:
`data-crandoria`, `data`, a pasta de backups e o socket do agente. O painel
nao ve `config.lua`, nao ve o `.env`, nao ve o codigo do site. Ele roda como
uid 6000, nao como root.

**3. O codigo confina o caminho.** Todo arquivo e resolvido com `realpath` e
comparado com a raiz da area; `..`, caminho absoluto e link simbolico nao
escapam. So grava `.lua`, `.xml`, `.json`, `.txt` e `.md`.

## Login

Sem app autenticador, por escolha: sao duas pessoas e ninguem quis. O que
substitui o segundo fator:

- senha guardada em **scrypt** com sal por usuario (N=2^15, ~100 ms por
  tentativa) — um dump vazado nao devolve a senha
- **bloqueio progressivo** por IP: 5 erros liberados, depois a espera dobra
  a cada 5, ate 30 minutos
- **fail2ban** lendo `logs/painel/auth.log`: 8 falhas em 15 min tiram o IP no
  firewall por 1 hora, antes de a requisicao chegar ao Node
- sessao de 8h deslizante com teto de 24h, cookie `HttpOnly` + `Secure` +
  `SameSite=Strict`, amarrada ao navegador
- **token anti-CSRF** em todo POST — sem ele, um site qualquer aberto na
  mesma sessao poderia disparar "reiniciar servidor"
- tudo que muda estado vai para `panel_audit`, com quem, quando e de onde

O subdominio e separado do site de proposito: o cookie do painel nunca viaja
junto com uma visita ao `crandoriaot.com.br`, e um furo no MyAAC nao alcanca
o painel.

## O editor

CodeMirror servido **pelo proprio painel**, nao por CDN — a politica de
seguranca da pagina so aceita script de origem propria, e assim o editor
funciona mesmo sem internet de saida. Tem numeracao de linha, destaque de
sintaxe para Lua/XML/JSON, casamento de chaves, busca no Ctrl+F, Ctrl+S para
salvar e aviso antes de sair com alteracao pendente. Indenta com tab, que e
o padrao dos scripts do servidor.

**Antes de gravar, todo `.lua` passa pelo luajit.** Se nao compilar, o painel
recusa e mostra a mensagem do proprio luajit (`unexpected symbol near '=='`),
sem encostar no arquivo. Isso existe porque um `==` no lugar de `=` no
`blessing.lua` ja impediu o servidor de subir uma vez. A validacao so compila
— `luajit -b` gera bytecode e descarta, codigo de topo de arquivo nao roda.

Toda substituicao guarda a versao anterior em `backups/scripts/`, com data no
nome. A poda automatica mantem 10 versoes por arquivo e 30 dias.

## Itens e duplicacao

A tela de itens soma **inventario + depot + inbox** e mostra, por item:
total, quantos jogadores tem, quanto esta com o maior detentor e a
**concentracao** — a fatia do estoque em uma unica mao. Item legitimo se
espalha; quando um jogador responde por quase todo o estoque de algo comum,
vale olhar. Tem tambem a lista de "mesmo item em varios chars da mesma
conta", que e o padrao de quem duplica e distribui para nao aparecer no
ranking individual.

Os nomes vem do `items.xml`, lido para a memoria na primeira consulta (38 mil
ids em ~60 ms, 8 MB de heap) e relido sozinho quando o arquivo muda. Nao ha
tabela no banco de proposito: uma tabela precisaria de reimportacao a cada
alteracao do XML, e a primeira vez que alguem esquecesse disso o painel
passaria a mostrar nome errado — pior do que nao mostrar nome nenhum. A busca
aceita nome ou id: "crystal coin" abre direto, "gold" lista os 60 que casam.

> **Os numeros so valem para quem esta offline.** O inventario de quem esta
> online mora na memoria do servidor e so desce para o banco no logout ou no
> save. O painel avisa isso na tela e mostra quantos estao online. Para um
> retrato exato, confira com o servidor vazio.

## Acoes no jogo

O painel nao fala com o servidor por protocolo nenhum — nao ha porta de
administracao aberta. Ele grava em `panel_commands` e um globalevent em Lua
consome a cada 5 segundos, do mesmo jeito que o sistema de doacoes ja faz.
Se o painel cair, o jogo nem percebe. Hoje aceita `kick`, `save` e
`broadcast`; qualquer outro tipo e recusado sem executar nada.

## Fuso horario

Os containers nascem em UTC, o que fazia o log do servidor marcar 18:05 quando
no Brasil eram 15:05. O `TZ` sozinho nao resolve porque nenhuma das imagens
traz o banco de fusos, entao o compose monta o `zoneinfo` do host em
`server`, `myacc`, `donate`, `painel` e `caddy`.

O `database` ficou de fora de proposito: colunas `TIMESTAMP` do MySQL sao
guardadas em UTC e convertidas na leitura pelo fuso da sessao, entao mudar o
fuso do container faria todo registro antigo do MyAAC aparecer tres horas
deslocado.

## Operacao

```bash
# logs do painel e do agente
docker compose -f docker-compose.yml -f docker-compose.prod.yml logs -f painel
journalctl -u crandoria-painel-agent -f

# reconstruir depois de mexer no codigo
docker compose -f docker-compose.yml -f docker-compose.prod.yml build painel
docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d painel

# recarregar o Caddy depois de mexer no Caddyfile
# (up -d nao basta: o compose nao recria o container so porque o arquivo
#  montado mudou)
docker exec crystalserver-caddy-1 caddy reload --config /etc/caddy/Caddyfile --adapter caddyfile
```

### Trocar a senha ou criar o segundo usuario

```bash
cd /opt/crandoria/docker
HASH=$(docker compose -f docker-compose.yml -f docker-compose.prod.yml \
  exec -T painel node tools/senha.js)          # a senha e digitada, nao vai em argv
P=$(grep -oP 'MYSQL_ROOT_PASSWORD=\K.*' .env)
docker exec crystalserver-database-1 mariadb -uroot -p"$P" crandoria -e \
  "INSERT INTO panel_users (username,password_hash,created_at)
   VALUES ('NOME','$HASH',UNIX_TIMESTAMP()*1000)
   ON DUPLICATE KEY UPDATE password_hash=VALUES(password_hash);"
```

### Se aparecer "sem permissao de escrita nesta pasta"

Pasta criada depois do ajuste inicial nasce sem escrita para o grupo:

```bash
chgrp -R painel /opt/crandoria/data-crandoria /opt/crandoria/data
chmod -R g+rwX  /opt/crandoria/data-crandoria /opt/crandoria/data
find /opt/crandoria/data-crandoria /opt/crandoria/data -type d -exec chmod g+s {} +
```

O `g+s` faz o que for criado ali nascer no grupo `painel`, evitando a
repeticao.

## O que fica de fora

Nao existe "desfazer" para reiniciar nem para parar o servidor. A edicao de
script tem backup, mas **entrar em vigor exige reiniciar** — salvar nao
recarrega o script sozinho.

O disco da maquina e pequeno (38 GB, ~68% em uso). Os dumps ficam em
`backups/db/` e nao sao apagados sozinhos: baixe e remova os antigos de vez
em quando.
