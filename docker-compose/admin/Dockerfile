FROM centos:7

ARG username
ARG password

#### git获取代码
WORKDIR /source/admin
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

FROM php:7.2-fpm-alpine as laravel

ARG CODE_PATH=/jikerone/admin

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

RUN  adduser -D -g '' www && \
     chown -R www ${CODE_PATH} 
USER www

EXPOSE 9003
CMD ["php-fpm"]