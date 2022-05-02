FROM ubuntu/apache2

COPY skylerspaeth.com/ /var/www/skylerspaeth.com/
COPY texasalohamassage.com/ /var/www/texasalohamassage.com/

COPY sites-enabled/* /etc/apache2/sites-enabled/
RUN rm /etc/apache2/sites-enabled/000-default.conf
