FROM php:7.4-apache-buster
WORKDIR /tmp
COPY install-dependencies.sh ./install-dependencies.sh
RUN ./install-dependencies.sh
COPY opcache-recommended.ini /usr/local/etc/php/conf.d/opcache-recommended.ini
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN mkdir /composer
ENV COMPOSER_HOME /composer
COPY install-composer.sh ./install-composer.sh
RUN ./install-composer.sh
RUN composer global require drush/drush
RUN composer create-project drupal/recommended-project /tmp/drupal && rm -rf /tmp/drupal
WORKDIR /drupal
RUN mkdir /drupal-files && chown www-data /drupal-files
COPY settings.php /templates/settings.php
RUN rm -rf /var/www/html 
RUN ln -s /drupal/web /var/www/html
COPY docker-drupal-entrypoint /usr/local/bin/docker-drupal-entrypoint
ENV PATH /composer/vendor/bin:$PATH
CMD ["apache2-foreground"]
ENTRYPOINT ["docker-drupal-entrypoint"]