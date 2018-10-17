FROM php:7.1.12-fpm
MAINTAINER Giampiero Lai <giampiero.lai@gmail.com>

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y g++ \
    libc-client-dev \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libkrb5-dev \
    libmagickwand-dev \
    libmcrypt-dev \
    libmcrypt-dev \
    libmemcached-dev \
    libpng12-dev \
    libpq-dev \
    libssl-dev \
    libssl-doc \
    libsasl2-dev \
    zlib1g-dev 

RUN docker-php-ext-install bz2 iconv mbstring mcrypt mysqli pgsql pdo_mysql pdo_pgsql soap zip

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl
RUN docker-php-ext-configure intl

RUN docker-php-ext-install gd imap intl

RUN pecl install imagick memcached mongodb redis xdebug 

RUN docker-php-ext-enable imagick memcached mongodb redis xdebug

RUN apt-get autoremove -y --purge 
RUN apt-get clean 
RUN rm -Rf /tmp/*