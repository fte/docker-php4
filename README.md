# docker-php4
PHP 4.4.9 in a Docker container for apple-m1 with Apache 2
```console
➜  docker-php4 git:(master) ✗ docker-compose down && docker-compose up -d --build && docker-compose exec php449 bash
[+] Running 2/2
 ⠿ Container docker-php4_php449_1  Removed                                                                                                                                                            10.5s
 ⠿ Network docker-php4_default     Removed                                                                                                                                                             4.2s
[+] Building 2.4s (18/18) FINISHED
 => [internal] load build definition from Dockerfile                                                                                                                                                   0.1s
 => => transferring dockerfile: 32B                                                                                                                                                                    0.0s
 => [internal] load .dockerignore                                                                                                                                                                      0.1s
 => => transferring context: 2B                                                                                                                                                                        0.0s
 => [internal] load metadata for docker.io/arm64v8/debian:9                                                                                                                                            1.6s
 => [auth] arm64v8/debian:pull token for registry-1.docker.io                                                                                                                                          0.0s
 => [internal] load build context                                                                                                                                                                      0.0s
 => => transferring context: 124B                                                                                                                                                                      0.0s
 => [ 1/12] FROM docker.io/arm64v8/debian:9@sha256:c6a9f957fcd08735e15eaf577d91d54fd435358303a08dd6d10dbb78e83d788b                                                                                    0.0s
 => CACHED [ 2/12] COPY docker /php-build/                                                                                                                                                             0.0s
 => CACHED [ 3/12] WORKDIR /php-build/                                                                                                                                                                 0.0s
 => CACHED [ 4/12] RUN apt-get update -y -qq                                                                                                                                                           0.0s
 => CACHED [ 5/12] RUN apt-get -y --no-install-recommends install -y apt-transport-https ca-certificates curl vim debconf-utils build-essential autotools-dev bison flex zlib1g-dev         libbz2-de  0.0s
 => CACHED [ 6/12] RUN tar xvf php-4.4.9.tar.bz2 &&     tar xvf openssl-0.9.8x.tar.gz                                                                                                                  0.0s
 => CACHED [ 7/12] RUN ln -s /usr/lib/aarch64-linux-gnu/libjpeg.so /usr/lib/ &&     ln -s /usr/lib/aarch64-linux-gnu/libpng.so /usr/lib/ &&     ln -s /usr/lib/aarch64-linux-gnu/libmysqlclient.so.18  0.0s
 => CACHED [ 8/12] WORKDIR /php-build/openssl-0.9.8x                                                                                                                                                   0.0s
 => CACHED [ 9/12] RUN ./config --prefix=/usr/local/openssl-0.9.8 && make -j8 && make install_sw                                                                                                       0.0s
 => CACHED [10/12] WORKDIR /php-build/php-4.4.9/                                                                                                                                                       0.0s
 => CACHED [11/12] RUN ./configure     --host aarch64-unknown-linux-gnu     --with-pdo-pgsql     --with-zlib-dir     --enable-mbstring     --with-libxml-dir=/usr     --enable-soap     --enable-cale  0.0s
 => CACHED [12/12] RUN apt-get -y install apache2 libapache2-mod-fcgid &&     a2enmod fcgid &&     cp /php-build/php-4.4.9/php.ini-dist /usr/local/lib/php.ini &&     echo "cgi.fix_pathinfo=1" >> /u  0.0s
 => exporting to image                                                                                                                                                                                 0.0s
 => => exporting layers                                                                                                                                                                                0.0s
 => => writing image sha256:38ade0914f596bee0e655e18f39da5a14a1a6d9d2000757dea592a19d32d51d6                                                                                                           0.0s
 => => naming to docker.io/library/docker-php4_php449                                                                                                                                                  0.0s
[+] Running 2/2
 ⠿ Network docker-php4_default     Created                                                                                                                                                             6.0s
 ⠿ Container docker-php4_php449_1  Started                                                                                                                                                             4.2s
root@a10170a7a183:/php-build/php-4.4.9# uname -a && php --version
Linux a10170a7a183 5.10.25-linuxkit #1 SMP PREEMPT Tue Mar 23 09:24:45 UTC 2021 aarch64 GNU/Linux
PHP 4.4.9 (cgi-fcgi) (built: Jul  7 2021 08:35:36)
Copyright (c) 1997-2008 The PHP Group
Zend Engine v1.3.0, Copyright (c) 1998-2004 Zend Technologies
root@a10170a7a183:/php-build/php-4.4.9#
```
 => [internal] load .dockerignore                                                                                                                                                                      0.1s
