# Inherit from the official Drupal 8 image.
FROM drupal:8

# Overwrite the Apache virtual host to point webroot to /var/www/html/web.
COPY vhost.conf /etc/apache2/sites-available/000-default.conf

