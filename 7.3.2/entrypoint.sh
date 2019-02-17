#!/bin/sh
set -e

if [ "$USER" = "root" ]; then

    # set localtime
    ln -sf /usr/share/zoneinfo/$LOCALTIME /etc/localtime

    # secure path
    chmod a-rwx -R $PHP_INI_DIR/conf.d/ /etc/ssmtp /usr/local/etc/php-fpm.d/
fi

echo '' > "$PHP_INI_DIR/conf.d/34-user.ini"

printenv $(printenv  | grep PHP__ | cut -d "=" -f1) > "$PHP_INI_DIR/conf.d/34-user.ini"
#
# PHP

echo "date.timezone = \"${LOCALTIME}\"" >> $PHP_INI_DIR/conf.d/34-user.ini

exec "$@"