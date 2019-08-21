FROM node:10
COPY ./ /app
WORKDIR /app
RUN curl -o- -L https://yarnpkg.com/install.sh | bash
RUN $HOME/.yarn/bin/yarn install
RUN yarn run deploy:prod

FROM nginx
RUN mkdir /app
COPY --from=0 /app/dist /app
COPY one-pro.conf /etc/nginx/nginx.conf