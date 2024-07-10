#!/bin/bash

# Appliquer les permissions nécessaires
chmod -R 775 /var/www/html/ipconfig.php
chmod -R 775 /var/www/html/uploads/
chmod -R 775 /var/www/html/uploads/archive/
chmod -R 775 /var/www/html/uploads/customer_files/
chmod -R 775 /var/www/html/uploads/temp/
chmod -R 775 /var/www/html/uploads/temp/mpdf/
chmod -R 775 /var/www/html/application/logs/
chown -R www-data:www-data /var/www/html

# Exécuter le script SQL
mysql -h invoiceplane-db -u ipdevdb -pipdevdb invoiceplane_db < /resources/docker/mariadb/docker-entrypoint-initdb.d/init.sql

