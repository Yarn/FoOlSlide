
FROM php:7.2.0-apache

RUN docker-php-ext-install mysqli

COPY ./php.ini /usr/local/etc/php/
COPY . /var/www/html/
RUN chmod -R 777 /var/www/html/

RUN a2enmod rewrite

LABEL Name=foolslide Version=0.0.1
