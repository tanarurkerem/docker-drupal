FROM php:7.4-apache-buster as base
WORKDIR /tmp
RUN apt-get update && \ 
    apt-get install -y --no-install-recommends \ 
    libfreetype6-dev \
    libjpeg-dev \
    libpng-dev \
    libpq-dev \
    libzip-dev && \ 
    apt-get install -y \
    git \
    unzip \
    zip \
    openssh-client

COPY install-dependencies.sh ./install-dependencies.sh
RUN ./install-dependencies.sh
COPY opcache-recommended.ini /usr/local/etc/php/conf.d/opcache-recommended.ini

FROM base as composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_MEMORY_LIMIT=-1
RUN mkdir /composer
ENV COMPOSER_HOME /composer
COPY install-composer.sh ./install-composer.sh
RUN ./install-composer.sh

FROM composer as drupal
ARG DRUPAL_VERSION
ENV DRUPAL_VERSION ${DRUPAL_VERSION}
WORKDIR /drupal
RUN rm -rf /var/www/html 
RUN ln -s /drupal/web /var/www/html
COPY templates /templates
COPY docker-drupal-entrypoint /usr/local/bin/docker-drupal-entrypoint
ENV PATH /drupal/vendor/bin:/composer/vendor/bin:$PATH
RUN docker-drupal-entrypoint
CMD ["apache2-foreground"]
ENTRYPOINT ["docker-drupal-entrypoint"]