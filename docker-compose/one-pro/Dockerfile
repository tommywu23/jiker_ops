#FROM registry.access.redhat.com/rhel7/rhel
FROM centos:7

ARG username
ARG password

# RUN rpm -e --nodeps yum && \
#     wget http://mirrors.aliyun.com/centos/7/os/x86_64/Packages/yum-3.4.3-132.el7.centos.0.1.noarch.rpm && \
#     wget http://mirrors.aliyun.com/centos/7/os/x86_64/Packages/yum-metadata-parser-1.1.4-10.el7.x86_64.rpm && \
#     wget http://mirrors.aliyun.com/centos/7/os/x86_64/Packages/yum-plugin-fastestmirror-1.1.31-34.el7.noarch.rpm && \
#     rpm -ivh yum-3.4.3-132.el7.centos.0.1.noarch.rpm yum-metadata-parser-1.1.4-10.el7.x86_64.rpm yum-plugin-fastestmirror-1.1.31-34.el7.noarch.rpm && \
RUN yum install -y yum-utils device-mapper-persistent-data lvm2 && \
    yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo && \
    yum makecache fast && \
    yum -y install docker-ce && \
    yum -y install bash git openssh nodejs && \
    node -v && \
    git clone http://${username}:${password}@git.weilaigongzuo.com/weilai/jiker-one-pro.git /app && \
    cd /app && \
    ls
WORKDIR /app
RUN curl -o- -L https://yarnpkg.com/install.sh | bash
RUN $HOME/.yarn/bin/yarn install
RUN yarn run deploy:prod

FROM nginx
RUN mkdir /var/wwwroot/one-pro
COPY --from=0 /app/dist /var/wwwroot/one-pro
COPY one-pro.conf /etc/nginx/nginx.conf