FROM php:8.1-apache-bullseye

HEALTHCHECK --retries=3 --timeout=60s CMD curl localhost
EXPOSE 80

# copy wp-config editor and apache config to container.
COPY ./scripts/config_editor.sh /usr/local/bin/
COPY ./app.conf /etc/apache2/sites-enabled/000-default.conf
#COPY ./wp-config-sample.php /var/www/html/wordpress/wp-config.php

# environment variables
ENV webroot=/var/www/html/
ENV app=/var/www/html/wordpress
ENV phplog=/var/log/php/php.log

ARG url=http://wordpress.org/latest.tar.gz

# Install wget, tar, and other tools.
# PHP log file in php.ini. Then create phplog file and change its owner
RUN ["/bin/bash", "-c", "apt update -y && apt install git wget tar zlib1g-dev libzip-dev libpng-dev -y \
&& wget -P $webroot $url \
&& echo 'error_log = $phplog' >> /usr/local/etc/php/php.ini-development \
&& echo 'error_log = $phplog' >> /usr/local/etc/php/php.ini-production \
&& echo 'ServerName 127.0.0.1' >> /etc/apache2/apache2.conf \
&& mkdir /var/log/php && touch $phplog && chown www-data:www-data $phplog"]

# install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql mysqli bcmath zip gd

WORKDIR $webroot
RUN ["/bin/bash", "-c", "tar -xzvf latest.tar.gz && chmod 755 -R $webroot && chown www-data:www-data -R $webroot"]

WORKDIR $app
RUN ["/bin/bash", "-c", "chmod 755 -R $app && chown www-data:www-data -R $app && config_editor.sh"]

ENTRYPOINT ["/bin/bash", "-c", "service apache2 restart && tail -f /dev/null"]
