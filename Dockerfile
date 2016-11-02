FROM php:5.6.27-apache

MAINTAINER blaze

LABEL version="1.0" description="Inherits the official php5-apache image. It additionally adds php5-mysql driver, configures apache and installs composer."

RUN docker-php-ext-install pdo pdo_mysql && \
    apt-get update && apt-get -y install git zip unzip && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === 'e115a8dc7871f15d853148a7fbac7da27d6c0030b848d9b3dc09e2a0388afed865e6a3d6b3c0fad45c48e2b5fc1196ae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/usr/bin --filename=composer && \
    php -r "unlink('composer-setup.php');" && \
    a2enmod rewrite

EXPOSE 80

CMD ["apache2-foreground"]