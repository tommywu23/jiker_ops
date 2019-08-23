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

RUN  adduser -D -g '' produser && \
     chown -R ${CODE_PATH}:${CODE_PATH} 
USER produser

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