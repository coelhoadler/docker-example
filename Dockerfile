FROM node:latest as node

WORKDIR /app

COPY package.json /app
RUN npm install --silent
COPY . .

RUN npm run ng build -c $NODE_ENV

FROM nginx:alpine

VOLUME /var/cache/nginx
COPY --from=node app/dist/angular-v10 /usr/share/nginx/html
COPY ./config/nginx.conf /etc/nginx/conf.d/default.conf