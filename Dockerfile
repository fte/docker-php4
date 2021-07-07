FROM arm64v8/debian:9
COPY docker /php-build/
WORKDIR /php-build/

RUN apt-get update -y -qq
RUN apt-get -y --no-install-recommends install -y apt-transport-https ca-certificates curl vim debconf-utils build-essential autotools-dev bison flex zlib1g-dev \
        libbz2-dev libcurl4-gnutls-dev libjpeg-dev libpng-dev libmcrypt-dev libmhash-dev default-libmysqlclient-dev libpq-dev libexpat1-dev

RUN tar xvf php-4.4.9.tar.bz2 && \
    tar xvf openssl-0.9.8x.tar.gz
RUN ln -s /usr/lib/aarch64-linux-gnu/libjpeg.so /usr/lib/ && \
    ln -s /usr/lib/aarch64-linux-gnu/libpng.so /usr/lib/ && \
    ln -s /usr/lib/aarch64-linux-gnu/libmysqlclient.so.18 /usr/lib/ && \
    ln -s /usr/lib/aarch64-linux-gnu/libexpat.so /usr/lib/ && \
    ln -s /usr/lib/aarch64-linux-gnu/libmysqlclient.so /usr/lib/libmysqlclient.so && \
    mkdir /usr/kerberos && \
    ln -s /usr/lib/aarch64-linux-gnu /usr/kerberos/lib && \
    ln -s /usr/include/aarch64-linux-gnu/curl /usr/include/curl

# Build OpenSSL 0.9.8x, since PHP 4 refuses to build with OpenSSL 1.0.0+
WORKDIR /php-build/openssl-0.9.8x
RUN ./config --prefix=/usr/local/openssl-0.9.8 && make -j8 && make install_sw

# Build PHP 4.4.9
WORKDIR /php-build/php-4.4.9/
RUN ./configure \
    --host aarch64-unknown-linux-gnu \
    --with-pdo-pgsql \
    --with-zlib-dir \
    --enable-mbstring \
    --with-libxml-dir=/usr \
    --enable-soap \
    --enable-calendar \
    --with-curl \
    --with-mcrypt \
    --with-zlib \
    --with-gd \
    --with-pgsql \
    --disable-rpath \
    --enable-inline-optimization \
    --with-bz2 \
    --with-zlib \
    --enable-sockets \
    --enable-sysvsem \
    --enable-sysvshm \
    --enable-pcntl \
    --enable-mbregex \
    --with-mhash \
    --enable-zip \
    --with-pcre-regex \
    --with-mysql \
    # --with-mysql-sock=/var/run/mysqld/mysqld.sock \
    --with-jpeg-dir=/usr \
    --with-png-dir=/usr \
    --enable-gd-native-ttf \
    --with-openssl=/usr/local/openssl-0.9.8 \
    --with-openssl-dir=/usr/local/openssl-0.9.8 \
    --with-libdir=/lib/aarch64-linux-gnu \
    --enable-ftp \
    # --with-imap \
    # --with-imap-ssl \
    --with-kerberos \
    --with-gettext \
    --with-expat-dir=/usr \
    --enable-fastcgi && \
    make -j8 && \
    make install

# Install Apache and configure it to use PHP via FastCGI
RUN apt-get -y install apache2 libapache2-mod-fcgid && \
    a2enmod fcgid && \
    cp /php-build/php-4.4.9/php.ini-dist /usr/local/lib/php.ini && \
    echo "cgi.fix_pathinfo=1" >> /usr/local/lib/php.ini && \
    sed -i 's/Options Indexes FollowSymLinks/Options Indexes FollowSymLinks ExecCGI/' /etc/apache2/apache2.conf

EXPOSE 80
