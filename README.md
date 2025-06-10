# Dockerfiles Examples for Laravel

## First to build
```bash
docker build -t php-laravel -f dockerfile-php-laravel 
```

## To build with mysql
```bash
docker build -t php-laravel-mysql -f dockerfile-php-fpm-nginx-mysql
```

## To build with pgsql
```bash
docker build -t php-laravel-pgsql -f dockerfile-php-fpm-nginx-pgsql
```

> In my case I need use --network=slirp4netns:enable_ipv6=false
