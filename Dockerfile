# This is a comment
FROM debian
MAINTAINER me <little.mole@arcor.de>

RUN /bin/echo -e "#!/bin/bash\nexit 0" > /usr/sbin/policy-rc.d 
RUN cat /usr/sbin/policy-rc.d
RUN /bin/echo -e "\nAcquire { \nRetries \"5\"; \n};\n" >> /etc/apt/apt.conf.d/70debconf
RUN cat /etc/apt/apt.conf.d/70debconf
RUN DEBIAN_FRONTEND=noninteractive apt-get update

# add php5.5 debian repository
RUN /bin/echo "deb http://packages.dotdeb.org wheezy-php55 all" >> /etc/apt/sources.list
RUN /bin/echo "deb-src http://packages.dotdeb.org wheezy-php55 all" >> /etc/apt/sources.list

# fetch the dotdeb package pgp keys
RUN apt-get install -y wget
RUN wget http://www.dotdeb.org/dotdeb.gpg -O /tmp/dotdeb.gpg
RUN apt-key add /tmp/dotdeb.gpg

# update and install php5 + redis
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y git php5 php5-dev redis-server python build-essential  autoconf curl

#RUN git clone https://github.com/phpredis/phpredis.git /opt/phpredis
#RUN cd /opt/phpredis && phpize && ./configure && make && make install

# enable apache2
COPY docker/default /etc/apache2/sites-available/000-default.conf
#COPY 21-redis.ini /etc/php5/apache2/conf.d/21-redis.ini

RUN cd /opt && \
    git clone https://github.com/edenhill/librdkafka.git && \
    cd librdkafka && ./configure && make && make install 

RUN ln -s /usr/local/lib/librdkafka.so /usr/lib/librdkafka.so
RUN ln -s /usr/local/lib/librdkafka.so.1 /usr/lib/librdkafka.so.1

RUN cd /opt && git clone https://github.com/EVODelavega/phpkafka.git && \
    cd phpkafka && phpize && ./configure --enable-kafka && make && \
    make install 

RUN a2enmod rewrite
RUN a2enmod php5

RUN sh -c 'echo "extension=/opt/phpkafka/modules/kafka.so" >> /etc/php5/apache2/conf.d/kafka.ini'


EXPOSE 80

ADD docker/run.sh /usr/local/bin/run.sh
COPY docker/kafka.php /var/www/

CMD ["/usr/local/bin/run.sh"]
