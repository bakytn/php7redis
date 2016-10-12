FROM php:7.0.11-cli
MAINTAINER Bakyt Niyazov bakytn@gmail.com

RUN apt-get update && apt-get install -y curl \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apt-get install -y git libmcrypt-dev g++ libicu-dev zlib1g-dev \
    && docker-php-ext-install mcrypt \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install zip \
#    && docker-php-ext-install soap \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl

RUN apt-get install -y libcurl4-openssl-dev pkg-config libssl-dev 
RUN pecl install mongodb-1.1.8
RUN docker-php-ext-enable mongodb

# Install Redis extension
ENV PHPREDIS_VERSION 3.0.0

RUN mkdir -p /usr/src/php/ext/redis \
    && curl -L https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz | tar xvz -C /usr/src/php/ext/redis --strip 1 \
    && echo 'redis' >> /usr/src/php-available-exts \
    && docker-php-ext-install redis
#

