FROM centos:7

ARG username
ARG password

#### git获取代码
WORKDIR /api
RUN yum install -y yum-utils device-mapper-persistent-data lvm2 && \
    yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo && \
    yum clean all && \
    yum --enablerepo=base clean metadata && \
    yum --enablerepo=updates clean metadata && \
    yum makecache fast && \
    yum install -y docker-ce && \
    yum install -y bash git openssh && \
    git clone http://${username}:${password}@git.weilaigongzuo.com/jiker-one/api.git /api && \
    git checkout edu-api 

FROM composer as composer
RUN mkdir -p /composer/api
COPY --from=0 /api /composer/api
RUN cd /composer/api \
      && ls \
      && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ \
      && composer install \
           --ignore-platform-reqs \
           --no-interaction \
           --no-plugins \
           --no-scripts \
           --prefer-dist 
COPY .env /composer/api/.env 
RUN  cat .env 

### 安装程序
# RUN composer install && \
#     php artisan key:generate && \
# 	php artisan jwt:secret && \
#     php artisan migrate && \
# 	php artisan db:seed --class=PermissionsSeeder && \
#     php artisan passport:keys 

# FROM nginx
# RUN useradd -ms /bin/bash produser
# USER produser
# RUN mkdir -p /opt/wwwroot/
# COPY --from=0 /backend /opt/wwwroot/
# COPY one-api.conf /etc/nginx/nginx.conf    