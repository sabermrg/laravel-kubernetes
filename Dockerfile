FROM php:7.2-fpm
COPY app /var/www/
EXPOSE 9000


#FROM php:7.3.3-apache-stretch
#WORKDIR /var/www/html
#COPY index.php index.php


# docker build -t smaraghi/php-apache
# docker run --name php-apache -t smaraghi/php-apache
# docker image push smaraghi/php-apache
######################################################
# compose file
# https://hub.docker.com/r/bitnami/laravel



version: '2'

services:
  mariadb:
    image: docker.io/bitnami/mariadb:10.6
    environment:
      # ALLOW_EMPTY_PASSWORD is recommended only for development.
      - ALLOW_EMPTY_PASSWORD=yes
      - MARIADB_USER=bn_myapp
      - MARIADB_DATABASE=bitnami_myapp
  myapp:
    image: docker.io/bitnami/laravel:9
    ports:
      - '8000:8000'
    environment:
      - DB_HOST=mariadb
      - DB_PORT=3306
      - DB_USERNAME=bn_myapp
      - DB_DATABASE=bitnami_myapp
    volumes:
      - './:/app'
    depends_on:
      - mariadb
