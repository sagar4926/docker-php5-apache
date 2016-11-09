FROM php:5.6.27-apache

MAINTAINER blaze

LABEL version="1.0" description="Inherits the official php5-apache image. It additionally adds php5-mysql driver, configures apache and installs composer."

RUN docker-php-ext-install pdo pdo_mysql && \
    apt-get update && apt-get -y install git zip unzip && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \    
    php -r "if (hash_file('SHA384', 'composer-setup.php') === 'aa96f26c2b67226a324c27919f1eb05f21c248b987e6195cad9690d5c1ff713d53020a02ac8c217dbf90a7eacc9d141d') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/usr/bin --filename=composer && \
    php -r "unlink('composer-setup.php');" && \
    a2enmod rewrite && a2enmod headers

EXPOSE 80

CMD ["apache2-foreground"]