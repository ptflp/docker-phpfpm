ARG PHP_VERSION
FROM php:7.3.2-fpm-alpine3.8

RUN apk add --no-cache --virtual .build-deps \
        libxml2-dev \
        shadow \
        autoconf \
        g++ \
        make \
        libpng-dev \
        freetype \
        libpng \
    && apk add --no-cache imagemagick imagemagick-dev libjpeg-turbo freetype-dev libjpeg-turbo-dev \
    && pecl install imagick-beta redis xdebug\
    && docker-php-ext-install pdo_mysql exif gd shmop mysqli \
    && docker-php-ext-enable redis xdebug imagick \
    && docker-php-ext-configure gd \
        --with-gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
    && NPROC=$(getconf _NPROCESSORS_ONLN) \
    && docker-php-ext-install -j${NPROC} gd \
    && mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
    && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
	&& composer global require "fxp/composer-asset-plugin:~1.4.2" \
	&& composer global require hirak/prestissimo \
    && apk del .build-deps


COPY entrypoint.sh /entrypoint.sh

WORKDIR /app

ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]