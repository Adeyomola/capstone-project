FROM php:8.1-apache-bullseye

HEALTHCHECK --retries=3 --timeout=60s CMD curl localhost
EXPOSE 80

COPY ./app.conf /etc/apache2/sites-enabled/000-default.conf
COPY ./wp-config-sample.php /var/www/html/app/config/wp-config.php

ENV webroot=/var/www/html/app
ENV phplog=/var/log/php/php.log

ARG url=http://wordpress.org/latest.tar.gz

# Install wget, tar, and other tools.
# PHP log file in php.ini. Then create phplog file and change its owner
RUN ["/bin/bash", "-c", "apt update -y && apt install git wget tar zlib1g-dev libzip-dev libpng-dev -y \
&& wget -c $url $webroot \
&& echo 'error_log = $phplog' >> /usr/local/etc/php/php.ini-development \
&& echo 'error_log = $phplog' >> /usr/local/etc/php/php.ini-production \
&& echo 'ServerName 127.0.0.1' >> /etc/apache2/apache2.conf \
&& mkdir /var/log/php && touch $phplog && chown www-data:www-data $phplog"]

# install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql mysqli bcmath zip gd

WORKDIR $webroot
RUN ["/bin/bash", "-c", "tar -xzvf latest.tar.gz && chmod 755 -R $webroot && chown www-data:www-data -R $webroot"]

ENTRYPOINT ["/bin/bash", "-c", "config_editor.sh && service apache2 restart && tail -f /dev/null"]
