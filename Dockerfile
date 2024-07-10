FROM php:8.1-fpm-alpine

ENV TZ=UTC
ENV APP_ROOT=/var/www/html

RUN apk update && apk add --no-cache \
    bash \
    nginx \
    supervisor \
    curl \
    git \
    libzip-dev \
    unzip \
    tzdata \
    && docker-php-ext-install pdo pdo_mysql zip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY ./supervisord.conf /etc/supervisord.conf

COPY . $APP_ROOT

WORKDIR $APP_ROOT
RUN composer install --no-dev --optimize-autoloader

RUN chown -R www-data:www-data $APP_ROOT

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
