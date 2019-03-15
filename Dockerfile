FROM drupal
RUN touch /var/www/html/nouveau_fichier
RUN touch /var/www/html/nouveau_fichier2.txt
# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer 
# Install git
RUN apt-get update
RUN apt-get -y install git
RUN composer global require drush/drush:9.* \
  && rm -f /usr/local/bin/drush \
  && ln -s ~/.composer/vendor/bin/drush /usr/local/bin/drush \
  && drush core-status -y \
  && rm -rf /var/lib/apt/lists/*
RUN cd /var/www/html && composer require drush/drush
RUN apt-get update && apt-get install -y mysql-client
RUN cd /var/www/html \
  && composer require drush/drush drupal/admin_toolbar  \ 
  && composer require drupal/devel --dev \
  && composer require drupal/config_split