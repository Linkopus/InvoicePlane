# Utiliser une image de base PHP avec FPM et Alpine Linux
FROM php:8.1-fpm-alpine

# Définir des variables d'environnement
ENV TZ=UTC
ENV APP_ROOT=/var/www/html

# Installer des dépendances système et Node.js
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
    nodejs \
    npm \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd bcmath pdo pdo_mysql zip

# Installer Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copier les fichiers de configuration
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
RUN ch
