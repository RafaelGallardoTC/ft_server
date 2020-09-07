#!/bin/bash
# NGINX Config
chown -R www-data:www-data /var/www/localhost
chmod -R 755 /var/www/*
ln -s /etc/nginx/sites-available/server_config /etc/nginx/sites-enabled/

# MySQL services and config
service mysql start && mysql -u root --password=< /tmp/create_wordpress_db.sql

# Generate SSL cert and key
chmod 700 /etc/ssl/private && \
    openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 -subj "/C=SP/ST=Spain/L=Madrid/O=42/CN=127.0.0.1" \
    -keyout /etc/ssl/private/nginx.key \
    -out /etc/ssl/certs/nginx.crt && \
    openssl dhparam -out /etc/nginx/dhparam.pem 1000