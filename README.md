# Drupal 8 Docker

## Approach 2: With Composer

```
mkdir -p sites/default/files
touch sites/default/settings.php
wget -P sites/default/ https://cgit.drupalcode.org/drupal/plain/sites/default/default.settings.php
sudo chown -R mstenta:www-data sites/default/
sudo docker-compose up
```
