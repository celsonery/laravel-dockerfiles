# Dockerfiles Examples for Laravel

## First to build
```bash
docker build --network=slirp4netns:enable_ipv6=false -t php-laravel -f dockerfile-php-laravel 
```

## To build with mysql
```bash
docker build --network=slirp4netns:enable_ipv6=false -t php-laravel-mysql -f dockerfile-php-fpm-nginx-mysql
```

## To build with pgsql
```bash
docker build --network=slirp4netns:enable_ipv6=false -t php-laravel-pgsql -f dockerfile-php-fpm-nginx-pgsql
```
