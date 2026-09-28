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
	&& docker-php-ext-install -j"$(nproc)" pdo_mysql zip gd intl mbstring opcache \
	&& a2enmod rewrite \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

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
