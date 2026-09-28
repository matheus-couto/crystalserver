FROM php:8.3-apache

# Extensoes que o instalador do MyAAC exige (pdo, pdo_mysql, xml, zip) mais as
# que as paginas usam na pratica (gd para imagens de guild, mbstring, intl).
# O xml ja vem compilado na imagem oficial.
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		libzip-dev \
		libpng-dev \
		libjpeg62-turbo-dev \
		libfreetype6-dev \
		libicu-dev \
		libonig-dev \
	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
	&& docker-php-ext-install -j"$(nproc)" pdo_mysql zip gd intl mbstring opcache bcmath \
	&& a2enmod rewrite remoteip headers \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Apache atras do Caddy.
#
# O MyAAC decide entre http:// e https:// olhando $_SERVER['HTTPS'] (veja
# common.php, define de SERVER_URL). Como o Caddy termina o TLS e fala com o
# Apache em texto puro, essa variavel nao existe e o site montava todos os
# links de CSS, JS e imagem como http:// dentro de uma pagina https. O
# navegador bloqueia isso como conteudo misto, e o layout aparece sem estilo.
#
# RemoteIP corrige outra consequencia do proxy: sem ele, todo acesso chega
# como o IP do container do Caddy, e o MyAAC grava esse IP como ultimo login
# da conta.
#
# Confiar nos cabecalhos e seguro aqui porque o Apache nao publica porta no
# host: so o Caddy alcanca este container.
RUN { \
		echo 'SetEnvIf X-Forwarded-Proto "^https$" HTTPS=on'; \
		echo 'RemoteIPHeader X-Forwarded-For'; \
		echo 'RemoteIPTrustedProxy 172.16.0.0/12'; \
		echo 'ServerName crandoriaot.com.br'; \
	} > /etc/apache2/conf-available/behind-proxy.conf \
	&& a2enconf behind-proxy

# Bloqueia o que nao deve ser servido.
#
# O MyAAC guarda config.php e config.local.php dentro do proprio webroot, com
# a senha do banco. Enquanto o PHP funciona eles sao executados e nao expoem
# nada, mas uma falha de modulo faz o Apache servir o codigo-fonte como texto.
# A pasta do instalador recria contas e reescreve configuracao, entao tambem
# fica fora do alcance.
RUN { \
		echo '<Files "config.local.php">'; \
		echo '  Require all denied'; \
		echo '</Files>'; \
		echo '<Files "config.php">'; \
		echo '  Require all denied'; \
		echo '</Files>'; \
		echo '<DirectoryMatch "^/var/www/html/(install|install old)">'; \
		echo '  Require all denied'; \
		echo '</DirectoryMatch>'; \
		echo '<FilesMatch "\.(sql|log|md|dist|bak|old|ini|yml|yaml|lock)$">'; \
		echo '  Require all denied'; \
		echo '</FilesMatch>'; \
		echo '<DirectoryMatch "/\.(git|svn)">'; \
		echo '  Require all denied'; \
		echo '</DirectoryMatch>'; \
		echo '# Listagem de diretorio revela estrutura e arquivos esquecidos.'; \
		echo '<Directory /var/www/html>'; \
		echo '  Options -Indexes +FollowSymLinks'; \
		echo '  AllowOverride All'; \
		echo '</Directory>'; \
	} > /etc/apache2/conf-available/hardening.conf \
	&& a2enconf hardening

# O MyAAC faz upload de imagens de guild; o padrao de 2M nao basta.
RUN { \
		echo 'upload_max_filesize=16M'; \
		echo 'post_max_size=16M'; \
		echo 'memory_limit=256M'; \
		echo 'expose_php=Off'; \
	} > /usr/local/etc/php/conf.d/myaac.ini

WORKDIR /var/www/html

# O codigo vem por bind mount no compose, nao copiado para a imagem: assim
# config.local.php e as pastas de imagens persistem entre deploys.
