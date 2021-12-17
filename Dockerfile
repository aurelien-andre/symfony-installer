FROM debian:bullseye-slim

ENV \
EMAIL='you@example.com' \
SYMFONY_VERSION='5.4'

RUN apt-get update \
&&  apt-get install -y --no-install-recommends \
software-properties-common \
apt-transport-https \
lsb-release \
ca-certificates \
gnupg \
gnupg1 \
gnupg2 \
wget \
git \
tini \
curl \
unzip

RUN apt-get update \
&&  wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add - \
&&  echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list

RUN apt-get update \
&&  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
supervisor \
nginx \
php8.0 \
php8.0-cli \
php8.0-fpm \
php8.0-common \
php8.0-bcmath \
php8.0-opcache \
php8.0-apcu \
php8.0-xdebug \
php8.0-curl \
php8.0-mbstring \
php8.0-mysql \
php8.0-xml \
php8.0-xsl \
php8.0-gd \
php8.0-intl \
php8.0-iconv \
php8.0-ftp \
php8.0-zip

RUN set -eux; \
rm -rf /etc/apt/sources.list.d/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

RUN wget https://get.symfony.com/cli/installer -O - | bash \
&&  mv /root/.symfony/bin/symfony /usr/local/bin/symfony

COPY docker/* /usr/bin

RUN set -eux; \
chmod +x -R /usr/bin; \
chmod +x -R /usr/sbin

WORKDIR /app

ENTRYPOINT ["docker-entrypoint"]

CMD ["symfony"]