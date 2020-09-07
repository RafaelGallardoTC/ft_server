FROM debian:buster

MAINTAINER rgallard<rgallard@student.42madrid.com>

COPY /srcs/server_config /etc/nginx/sites-available/
COPY /srcs/create_wordpress_db.sql /tmp
COPY /srcs/wordpress/ /var/www/localhost/
COPY /srcs/phpmyadmin/ /var/www/localhost/phpmyadmin/
COPY /srcs/take_off.sh /tmp

RUN apt update -y
RUN apt install -y nginx vim php7.3-fpm php-mysql mariadb-server openssl ufw && \
    chmod u+x /tmp/take_off.sh
RUN /tmp/take_off.sh

CMD service nginx start && service php7.3-fpm start && service mysql start && bash