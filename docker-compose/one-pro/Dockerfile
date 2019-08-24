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
    yum clean all && \
    yum --enablerepo=base clean metadata && \
    yum --enablerepo=updates clean metadata && \
    yum makecache fast && \
    yum install -y docker-ce && \
    yum install -y bash git openssh && \
    git clone -b dev http://${username}:${password}@git.weilaigongzuo.com/weilai/jiker-one-pro.git /app && \
    cd /app 
WORKDIR /app
RUN curl --silent --location https://rpm.nodesource.com/setup_10.x | bash && \
    yum install -y nodejs 
#     curl -o- -L https://yarnpkg.com/install.sh | bash && \
#     $HOME/.yarn/bin/yarn install 

ENV YARN_VERSION 1.17.3
RUN set -ex \
    && for key in \
        6A010C5166006599AA17F08146C2130DFD2497F5 \
    ; do \
        gpg --keyserver pgp.mit.edu --recv-keys "$key" || \
        gpg --keyserver keyserver.pgp.com --recv-keys "$key" || \
        gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" ; \
    done \
    && curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" \
    && curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz.asc" \
    && gpg --batch --verify yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz \
    && mkdir -p /opt/yarn \
    && tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/yarn --strip-components=1 \
    && ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn \
    && ln -s /opt/yarn/bin/yarn /usr/local/bin/yarnpkg \
    && rm yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz
RUN yarn install && \
    yarn run deploy:local && \
    ls -a

CMD ["echo","hello Jiker one pro"]