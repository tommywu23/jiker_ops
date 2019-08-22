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
    git checkout edu-api && \
    cd /api && ls 

### 安装程序
RUN composer install && \
    cp .env.example .env && \
    php artisan key:generate && \
	php artisan jwt:secret && \
    php artisan migrate && \
	php artisan db:seed --class=PermissionsSeeder && \
    php artisan passport:keys 

FROM nginx
RUN useradd -ms /bin/bash produser
USER produser
RUN mkdir -p /opt/wwwroot/
COPY --from=0 /backend /opt/wwwroot/
COPY one-api.conf /etc/nginx/nginx.conf    