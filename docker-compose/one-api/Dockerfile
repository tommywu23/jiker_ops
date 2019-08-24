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
    git clone -b edu-api http://${username}:${password}@git.weilaigongzuo.com/jiker-one/api.git /source/api 

FROM composer:1.9 as composer

FROM php:7.2-fpm-alpine as laravel

### 安装PHP依赖
RUN   apk update \                                                                                                                                                                                                                        
  &&   apk add ca-certificates wget \                                                                                                                                                                                                      
  &&   update-ca-certificates
RUN docker-php-ext-install bcmath bz2 calendar ctype curl \
        date dom exif fileinfo filter ftp gd gettext hash iconv json ldap \
        libxml mbstring mysqli mysqlnd openssl pcntl pcre pdo pdo_mysql \
        pdo_sqlite posix readline Reflection session shmop SimpleXML soap \
        sockets SPL sqlite3 standard sysvmsg sysvsem sysvshm tokenizer wddx \
        xml xmlreader xmlrpc xmlwriter xsl zip zlib Core mcrypt Phar

ARG CODE_PATH=/jikerone/api

WORKDIR ${CODE_PATH}

RUN mkdir -p ${CODE_PATH} && \
    cd ${CODE_PATH} 

COPY --from=0 /source/api ${CODE_PATH}
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

RUN  addgroup -s www && adduser -D -r -g '' www www && \
     chown -R www:www ${CODE_PATH} 
USER www

EXPOSE 9002
CMD ["php-fpm"]
# CMD php-fpm && \
#         /bin/sh -c \ 
#         php artisan key:generate && \
#         php artisan jwt:secret && \
#         php artisan migrate && \
#         php artisan db:seed --class=PermissionsSeeder && \
#         php artisan passport:keys  

# FROM nginx 

# ARG RUNTIME_PATH=/var/wwwroot/api

# RUN useradd -ms /bin/bash produser
# USER produser
# RUN mkdir -p ${RUNTIME_PATH}
# COPY --from=laravel /jikerone/api ${RUNTIME_PATH}
# RUN cd ${RUNTIME_PATH} && ls -a
# COPY one-api.conf /etc/nginx/nginx.conf    