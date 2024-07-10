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
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd bcmath pdo pdo_mysql zip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY ./resources/docker/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./resources/docker/nginx/invoiceplane.conf /etc/nginx/conf.d/default.conf

# Copier le code de l'application
COPY . $APP_ROOT

# Définir le répertoire de travail
WORKDIR $APP_ROOT

# Installer les dépendances PHP avec Composer
RUN composer install --no-dev --optimize-autoloader

# Installer Yarn
RUN npm install -g yarn

# Installer les dépendances Node.js avec Yarn
RUN yarn install

# Exécuter Grunt pour construire les fichiers statiques
RUN yarn global add grunt-cli
RUN grunt

# Changer le propriétaire des fichiers de l'application
RUN chown -R www-data:www-data $APP_ROOT

# Exposer les ports nécessaires
EXPOSE 80

