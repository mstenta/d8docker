# Drupal 8 Docker

## Approach 1: Without Composer

```
git clone https://github.com/drupal-composer/drupal-project.git volume
sudo docker run --rm -it -v ${PWD}/volume:/app --user $(id -u):$(id -g) composer install --ignore-platform-reqs
mkdir -p volume/config/sync
sudo docker-compose up
```
