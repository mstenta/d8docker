# Inherit from the official Drupal 8 image.
FROM drupal:8

# Remove /var/www/html.
RUN rm -r /var/www/html

# Install Composer.
# Per the instructions here (but with curl instead of wget):
# https://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md
RUN EXPECTED_SIGNATURE="$(curl https://composer.github.io/installer.sig)" \
  && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', 'composer-setup.php');")" \
  && if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]; \
  then \
      >&2 echo 'ERROR: Invalid installer signature' \
      && rm composer-setup.php \
      && exit 1; \
  fi \
  && php composer-setup.php --quiet \
  && RESULT=$? \
  && rm composer-setup.php \
  && mv composer.phar /usr/local/bin/composer \
  && exit $RESULT

# Install Git.
RUN apt-get update && apt-get install -y git

# Clone the project repository into /var/www/html.
RUN git clone https://github.com/drupal-composer/drupal-project.git /var/www/html

# Install with Composer.
RUN composer install

# Create config/sync directory.
RUN mkdir -p /var/www/html/config/sync

# Overwrite the Apache virtual host to point webroot to /var/www/html/web.
COPY vhost.conf /etc/apache2/sites-available/000-default.conf

