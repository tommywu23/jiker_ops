FROM centos:7

ARG username
ARG password

#### git获取代码
WORKDIR /source/api
RUN yum install -y yum-utils device-mapper-persistent-data lvm2 && \
    yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo && \
    yum clean all && \
    yum --enablerepo=base clean metadata && \
    yum --enablerepo=updates clean metadata && \
    yum makecache fast && \
    yum install -y docker-ce && \
    yum install -y bash git openssh && \
    git clone -b one http://${username}:${password}@git.weilaigongzuo.com/jiker-edu/admin.git /source/admin 
 
FROM composer:1.9 as composer

FROM daocloud.io/library/php:7.2.16-fpm

RUN sed -i 's/deb.debian.org/mirrors.aliyun.com/g'  /etc/apt/sources.list
RUN sed -i 's/security.debian.org/mirrors.aliyun.com/g'  /etc/apt/sources.list

RUN apt-get update && apt-get install -y libbz2-dev libfreetype6-dev libjpeg62-turbo-dev \
        libmcrypt-dev libpng-dev libldap2-dev gettext libxml2-dev libxslt1-dev 

RUN docker-php-ext-install bcmath
RUN docker-php-ext-install bz2
RUN docker-php-ext-install calendar
RUN docker-php-ext-install exif
RUN docker-php-ext-install iconv
 
RUN echo -e "\n" | pecl  install http://pecl.php.net/get/mcrypt-1.0.2.tgz
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd
RUN docker-php-ext-install gettext ldap mysqli pcntl pdo_mysql
RUN docker-php-ext-install shmop soap sockets sysvmsg sysvsem sysvshm wddx xmlrpc xsl zip

ARG CODE_PATH=/jikerone/admin

WORKDIR ${CODE_PATH}

RUN mkdir -p ${CODE_PATH} && \
    cd ${CODE_PATH} 

COPY --from=0 /source/admin ${CODE_PATH}
COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ && \
        composer install \
           --ignore-platform-reqs \
           --no-interaction \
           --no-plugins \
           --no-scripts \
           --no-dev \
           --prefer-dist 
COPY .env ${CODE_PATH} 

RUN  chown -R 777 www-data.www-data ${CODE_PATH} 
USER www-data

EXPOSE 9003

CMD ["php-fpm"]