FROM ubuntu:latest
RUN apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
RUN ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN apt-get install -y unzip apache2 apache2-utils
RUN apt-get install -y php7.2 libapache2-mod-php7.2
RUN apt-get install -y php7.2-ldap php7.2-zip php7.2-gd php7.2-dom php7.2-mbstring php7.2-mysql
RUN apt-get install -y composer
RUN apt-get install -y wget
RUN phpenmod mcrypt
RUN phpenmod openssl
RUN phpenmod mbstring
RUN phpenmod dom
RUN phpenmod gd
RUN phpenmod zip
RUN wget -O jorani.tar.gz https://github.com/bbalet/jorani/archive/master.tar.gz
RUN rm -Rf /var/www/html
RUN tar zxvf jorani.tar.gz
RUN mv /jorani-master /var/www/html/
RUN a2enmod rewrite
COPY 000-default.conf /etc/apache2/sites-enabled/000-default.conf
COPY database.php /var/www/html/application/config/database.php
COPY email.php /var/www/html/application/config/email.php
RUN sed -i "s^\['sess_driver'\] = 'database'^\['sess_driver'\] = 'files'^g" /var/www/html/application/config/config.php
RUN sed -i "s^\['sess_save_path'\] = ''^\['sess_save_path'\] = '/tmp/sess'^g" /var/www/html/application/config/config.php
RUN composer install -d /var/www/html
# Configure Apache2
ENV APACHE_RUN_USER     www-data
ENV APACHE_RUN_GROUP    www-data
ENV APACHE_LOG_DIR      /var/log/apache2
env APACHE_PID_FILE     /var/run/apache2.pid
env APACHE_RUN_DIR      /var/run/apache2
env APACHE_LOCK_DIR     /var/lock/apache2
env APACHE_LOG_DIR      /var/log/apache2
WORKDIR /var/www/html
EXPOSE 80
ENTRYPOINT [ "/usr/sbin/apache2", "-DFOREGROUND" ]
