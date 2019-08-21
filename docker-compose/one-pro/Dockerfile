FROM registry.access.redhat.com/rhel7/rhel

ARG username
ARG password

RUN yum update && yum upgrade && \
    yum add --no-cache bash git openssh 
RUN git clone http://${username}:${password}@git.weilaigongzuo.com/weilai/jiker-one-pro.git

FROM node:10
COPY ./ /app
WORKDIR /app
RUN curl -o- -L https://yarnpkg.com/install.sh | bash
RUN $HOME/.yarn/bin/yarn install
RUN yarn run deploy:prod

#FROM nginx
RUN mkdir /var/wwwroot/one-pro
COPY --from=0 /app/dist /var/wwwroot/one-pro
#COPY one-pro.conf /etc/nginx/nginx.conf