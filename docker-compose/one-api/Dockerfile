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
    git clone -b dev http://${username}:${password}@git.weilaigongzuo.com/jiker-one/api.git /source/api 
    # git clone -b one http://${username}:${password}@git.weilaigongzuo.com/jiker-edu/admin.git /source/admin && \
    # git clone -b dev http://${username}:${password}@git.weilaigongzuo.com/weilai/jiker-one-pro.git /source/pro 

FROM php:7.2-fpm-alpine as laravel

ARG CODE_PATH=/jikerone/api

# RUN useradd -u 1000 -ms /bin/bash produser
# USER produser
# RUN apk add --no-cache \
#         curl \
#         git \
RUN rm -f /usr/local/bin/composer && \
    curl -s https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    mkdir -p ${CODE_PATH}
WORKDIR ${CODE_PATH}
COPY --from=0 /source/api ${CODE_PATH}
RUN cd ${CODE_PATH} && \
       composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ && \
       composer install \
           --ignore-platform-reqs \
           --no-interaction \
           --no-plugins \
           --no-scripts \
           --no-dev \
           --prefer-dist 
COPY .env ${CODE_PATH} 
RUN cd ${CODE_PATH} && ls -a && \
    useradd -u 1000 -ms /bin/bash produser
USER produser
EXPOSE 9002
CMD ["php-fpm"]  

# FROM nginx 

# ARG RUNTIME_PATH=/var/wwwroot/api

# RUN useradd -ms /bin/bash produser
# USER produser
# RUN mkdir -p ${RUNTIME_PATH}
# COPY --from=laravel /jikerone/api ${RUNTIME_PATH}
# RUN cd ${RUNTIME_PATH} && ls -a
# COPY one-api.conf /etc/nginx/nginx.conf    