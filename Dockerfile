FROM ubuntu:17.04

RUN apt-get -y update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
   apache2 \
   cron \
   curl \
   less \
   libapache2-mod-php \
   nano \
   p7zip \
   php \
   php-curl \
   php-gd \
   php-mbstring \
   php-mcrypt \
   php-mysql \
   php-sqlite3 \
   php-xml \
   php-xmlrpc \
   postfix \
   wget

RUN cp /etc/apache2/conf-available/security.conf /etc/apache2/conf-available/security_old.conf; \
   cat /etc/apache2/conf-available/security.conf | sed -e 's#ServerTokens OS#ServerTokens Prod#g' -e 's#ServerSignature On#ServerSignature Off#g' > security.conf; \
   cat /etc/apache2/apache2.conf | sed "s#Timeout 300#Timeout 30#g" > apache2.conf; \
   mv apache2.conf /etc/apache2/apache2.conf; \
   mv security.conf /etc/apache2/conf-available/security.conf

WORKDIR /setup
RUN wget http://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz; \
   tar xvf dokuwiki-stable.tgz; \
   mv dokuwiki-*/ dokuwiki

COPY helper/dokuwiki-* /usr/bin/

RUN chmod 700 /usr/bin/dokuwiki-*

ENTRYPOINT ["dokuwiki-configure"]

   




