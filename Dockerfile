FROM ubuntu:latest
 
LABEL "project"="barista"
LABEL "author"="poojitha"
  
RUN apt-get update
RUN apt install apache2 -y
  
ENV DEBIAN_FRONTEND=non-interactive
  
CMD ["/usr/sbin/apache2ctl","-D","FOREGROUND"]
  
EXPOSE 80
  
WORKDIR /var/www/html/
VOLUME /var/apache2/log/
  
ADD barista.tar.gz /var/www/html
