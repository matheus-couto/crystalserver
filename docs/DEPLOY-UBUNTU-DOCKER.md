# Deploy no Ubuntu Server com Docker

Passo a passo para subir o Crandoria (servidor de jogo + MyAAC + worker de
doações) num Ubuntu Server usando Docker Compose.

> **Ainda não testado num servidor real.** Foi escrito a partir do que existe no
> repositório e do que já validamos na máquina local. Na hora do deploy, siga na
> ordem e confira a saída de cada passo — alguns valores dependem do seu provedor.

---

## 0. O que precisa existir antes

**Servidor:** Ubuntu Server 22.04 ou 24.04, 64 bits.

**Recursos.** O ponto crítico é a **compilação**. O `Dockerfile.dev` compila o
servidor do zero dentro do container, e o vcpkg constrói protobuf,
opentelemetry-cpp, boost e curl junto. Na sua máquina Windows, com 16 threads,
isso levou 24 minutos.

| Recurso | Mínimo | Confortável |
|---|---|---|
| vCPU | 4 | 8 |
| RAM | 8 GB | 16 GB |
| Disco | 40 GB | 80 GB |

Com menos de 8 GB o build tende a ser morto pelo OOM killer no meio do
protobuf. Se a sua VPS for menor, veja a alternativa no passo 5.

**Domínio.** Aponte um registro A para o IP do servidor. Você vai precisar dele
para o cliente e para o webhook do Asaas.

---

## 1. Docker

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y ca-certificates curl git

sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
| sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo usermod -aG docker $USER
newgrp docker
docker compose version
```

---

## 2. Clonar o repositório

```bash
sudo mkdir -p /opt/crandoria && sudo chown $USER:$USER /opt/crandoria
git clone https://github.com/matheus-couto/crystalserver.git /opt/crandoria
cd /opt/crandoria
```

---

## 3. Subir o que **não** está no git

Esta é a parte que ninguém lembra e que trava o deploy. Estes arquivos estão no
`.gitignore` de propósito — por tamanho ou por conterem senha — então o clone
**não** os traz.

| Arquivo | Por que ficou de fora |
|---|---|
| `data-crandoria/world/crandoria.otbm` | 126 MB, acima do limite do GitHub |
| `data-crandoria/world/world.otbm` | 51 MB |
| `config.lua` | contém a senha do banco |
| `myacc/config.local.php` | contém a senha do banco |
| `tools/asaas-donate/.env` | contém a chave da API do Asaas |

Da sua máquina Windows (PowerShell), com `scp`:

```powershell
$SRV = "usuario@SEU_IP"
scp "D:\crandoria\crystalserver\data-crandoria\world\crandoria.otbm" "${SRV}:/opt/crandoria/data-crandoria/world/"
scp "D:\crandoria\crystalserver\data-crandoria\world\world.otbm"     "${SRV}:/opt/crandoria/data-crandoria/world/"
scp "D:\crandoria\crystalserver\config.lua"                          "${SRV}:/opt/crandoria/"
```

O mapa tem 126 MB; numa conexão doméstica isso leva alguns minutos.

---

## 4. Configuração

### 4.1 `docker/.env`

```bash
cd /opt/crandoria/docker
cp .env.dist .env
nano .env
```

Troque **todas** as senhas padrão e ajuste o IP:

```ini
MYSQL_DATABASE=crandoria
MYSQL_USER=crandoria
MYSQL_PASSWORD=<senha-forte>
MYSQL_ROOT_PASSWORD=<outra-senha-forte>

MYSQL_HOST=database
MYSQL_DBNAME=crandoria
SERVER_NAME=Crandoria
SERVER_IP=<IP_PUBLICO_DO_SERVIDOR>
SERVER_LOCATION=BRA

statusProtocolPort=7171
gameProtocolPort=7172
```

### 4.2 `config.lua`

No arquivo que você subiu no passo 3:

```lua
ip = "SEU_IP_PUBLICO"          -- não deixe 127.0.0.1
mysqlHost = "database"         -- nome do serviço no compose, não localhost
mysqlUser = "crandoria"
mysqlPass = "<a mesma senha do .env>"
mysqlDatabase = "crandoria"
dataPackDirectory = "data-crandoria"

donateEnabled = true
donateCoinsPerReal = 10
```

> O `start.sh` reescreve `mysqlHost`, `mysqlUser`, `mysqlPass`, `ip` e as portas
> a partir das variáveis de ambiente quando o container sobe. Deixar coerente
> nos dois lugares evita confusão na hora de depurar.

### 4.3 `myacc/config.local.php`

```bash
nano /opt/crandoria/myacc/config.local.php
```

```php
<?php
$config['installed'] = true;
$config['env'] = 'prod';
$config['server_path'] = '/srv/crystalserver/';
$config['date_timezone'] = 'America/Sao_Paulo';

$config['database_host'] = 'database';
$config['database_port'] = '3306';
$config['database_user'] = 'crandoria';
$config['database_password'] = '<a mesma senha>';
$config['database_name'] = 'crandoria';

// Char Bazaar
$config['bazaar_create'] = 50;
$config['bazaar_tax'] = 12;
$config['bazaar_bid'] = 50;
$config['bazaar_accountid'] = 1;  // troque por uma conta dedicada
```

### 4.4 `tools/asaas-donate/.env`

```bash
cd /opt/crandoria/tools/asaas-donate
cp .env.example .env
nano .env
```

```ini
ASAAS_BASE_URL=https://api.asaas.com/v3
ASAAS_API_KEY=<sua chave de produção>
ASAAS_WEBHOOK_TOKEN=<token longo e aleatório>

DB_HOST=database
DB_USER=crandoria
DB_PASSWORD=<a mesma senha>
DB_NAME=crandoria
PORT=3000
```

Comece pelo **sandbox** (`https://api-sandbox.asaas.com/v3`) e só troque para
produção depois de uma doação de teste passar ponta a ponta. A chave tem que ser
do mesmo ambiente da URL.

---

## 5. Build e subida

```bash
cd /opt/crandoria/docker
docker compose -f docker-compose.yml -f docker-compose.prod.yml build
docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d
docker compose logs -f server
```

O primeiro build demora bastante (o vcpkg compila tudo). Acompanhe com
`docker stats` em outra sessão; se o container do build sumir sem erro, foi o
OOM killer — adicione swap:

```bash
sudo fallocate -l 8G /swapfile && sudo chmod 600 /swapfile
sudo mkswap /swapfile && sudo swapon /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
```

**Alternativa se a VPS for pequena:** compile a imagem numa máquina maior, empurre
para um registry e puxe no servidor. Evita o build no servidor por completo.

```bash
# numa máquina com folga
docker build -f docker/Dockerfile.dev --target prod -t SEU_USUARIO/crandoria:latest .
docker push SEU_USUARIO/crandoria:latest
# no servidor, troque o bloco build: do serviço server por image: SEU_USUARIO/crandoria:latest
```

Confira o que subiu:

```bash
docker compose -f docker-compose.yml -f docker-compose.prod.yml ps
```

---

## 6. Instalar o MyAAC

Abra `http://SEU_DOMINIO/install` e siga o instalador.

> **Atenção:** o instalador **reescreve o `config.local.php` inteiro**. Depois de
> concluir, abra o arquivo e recoloque o bloco do Char Bazaar e as credenciais do
> banco do passo 4.3. Isso já aconteceu uma vez no ambiente local.

Terminada a instalação, renomeie a pasta do instalador:

```bash
mv /opt/crandoria/myacc/install /opt/crandoria/myacc/install-old
```

---

## 7. O cliente — leia antes de distribuir

O cliente oficial tem a URL de login **fixa dentro do binário**:

```
http://127.0.0.1/login.php
```

Extraí essa string do `client.exe`. Como está apontando para `127.0.0.1`, o
cliente que você tem hoje **só funciona na sua máquina**. Para os jogadores, o
binário precisa ser repontado para o seu domínio, com um IP changer ou editor
hexadecimal.

Um detalhe que costuma morder: a string nova precisa **caber no mesmo espaço** da
antiga, salvo se a ferramenta souber realocar. `http://127.0.0.1/login.php` tem
26 caracteres, então `http://200.201.202.203/login.php` (32) não entra direto,
mas um domínio curto como `http://crandoria.to/login.php` (29) também não. Teste
antes de distribuir.

O `docker/DOCKER.md` original sugere apontar o cliente para a porta 8080, do
container `login`. Aqui o MyAAC responde o `/login.php` na porta 80, que é o que
o seu cliente já espera — por isso o `login` do compose base é dispensável no seu
caso. Se não for usar, pare o serviço:

```bash
docker compose -f docker-compose.yml -f docker-compose.prod.yml stop login
```

---

## 8. Webhook do Asaas

No painel do Asaas → **Integrações → Webhooks**:

| Campo | Valor |
|---|---|
| URL | `https://SEU_DOMINIO/asaas/webhook` |
| Token | o mesmo `ASAAS_WEBHOOK_TOKEN` do `.env` |
| Eventos | `PAYMENT_RECEIVED`, `PAYMENT_CONFIRMED`, `PAYMENT_REFUNDED` |

O worker escuta na porta 3000. Para servir por HTTPS (o Asaas não gosta de HTTP
puro em produção), ponha um proxy na frente:

```bash
sudo apt install -y nginx certbot python3-certbot-nginx
```

`/etc/nginx/sites-available/crandoria`:

```nginx
server {
    listen 80;
    server_name SEU_DOMINIO;

    location /asaas/webhook {
        proxy_pass http://127.0.0.1:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    location / {
        proxy_pass http://127.0.0.1:80;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

> Se usar este nginx no host, o MyAAC não pode ocupar a porta 80. Troque o
> mapeamento no `docker-compose.prod.yml` para `'127.0.0.1:8081:80'` e ajuste o
> `proxy_pass` do bloco `/` para `http://127.0.0.1:8081`.

```bash
sudo ln -s /etc/nginx/sites-available/crandoria /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl reload nginx
sudo certbot --nginx -d SEU_DOMINIO
```

Teste o endpoint:

```bash
curl -i -X POST https://SEU_DOMINIO/asaas/webhook \
  -H 'Content-Type: application/json' \
  -H 'asaas-access-token: token-errado' \
  -d '{"event":"PAYMENT_RECEIVED","payment":{"id":"x"}}'
# esperado: HTTP 401
```

---

## 9. Firewall

```bash
sudo ufw allow OpenSSH
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 7171/tcp
sudo ufw allow 7172/tcp
sudo ufw enable
sudo ufw status
```

**Não** abra a 3306. O banco fala com os outros containers pela rede interna do
compose. Se quiser acessá-lo da sua máquina, use um túnel SSH:

```bash
ssh -L 3306:127.0.0.1:3306 usuario@SEU_IP
```

E remova o mapeamento `'$MYSQL_PORT:3306'` do `docker-compose.yml`, que hoje
expõe o banco para fora.

---

## 10. Backup

O mapa não está no git e o banco é o seu servidor inteiro. Crie
`/opt/crandoria/backup.sh`:

```bash
#!/bin/bash
set -e
DEST=/opt/backups
DATE=$(date +%Y%m%d-%H%M)
mkdir -p "$DEST"

docker compose -f /opt/crandoria/docker/docker-compose.yml exec -T database \
  mysqldump -u root -p"$MYSQL_ROOT_PASSWORD" --single-transaction crandoria \
  | gzip > "$DEST/db-$DATE.sql.gz"

tar -czf "$DEST/world-$DATE.tar.gz" -C /opt/crandoria data-crandoria/world

find "$DEST" -name '*.gz' -mtime +7 -delete
```

```bash
chmod +x /opt/crandoria/backup.sh
sudo crontab -e
# 0 4 * * * MYSQL_ROOT_PASSWORD=<senha> /opt/crandoria/backup.sh
```

Leve os arquivos para fora do servidor com alguma frequência. Backup no mesmo
disco não protege contra a perda do disco.

---

## 11. Dia a dia

```bash
cd /opt/crandoria/docker
alias dc='docker compose -f docker-compose.yml -f docker-compose.prod.yml'

dc ps                      # o que está no ar
dc logs -f server          # log do servidor de jogo
dc logs -f donate          # log do worker de doações
dc restart server          # reiniciar só o jogo
dc up -d --build server    # recompilar após mudar o C++
dc down                    # parar tudo
```

**Atualizar o servidor** (as alterações em Lua entram só reiniciando; C++ exige
rebuild):

```bash
cd /opt/crandoria
git pull origin main
cd docker && dc up -d --build server
```

**Puxar atualizações do upstream:**

```bash
git fetch upstream
git merge upstream/main
```

---

## 12. Checklist final

- [ ] `dc ps` mostra `database`, `server`, `myacc` e `donate` como `Up`
- [ ] `dc logs server` termina em `World [1 - ...] is online!`
- [ ] Portas 7171 e 7172 respondem de fora (`nc -vz SEU_IP 7171`)
- [ ] `https://SEU_DOMINIO` abre o MyAAC
- [ ] Webhook com token errado devolve 401
- [ ] Cliente repontado para o seu domínio conecta e loga
- [ ] `!donate 5` entrega o scroll com o link
- [ ] Uma doação de teste no sandbox credita as coins
- [ ] Backup roda e o `.sql.gz` tem tamanho coerente
