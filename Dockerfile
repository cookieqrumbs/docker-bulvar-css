FROM node:19.7 AS build-css

WORKDIR /usr/src
COPY  assets/                   ./assets
COPY  main.scss  package*.json  ./

RUN npm install && \
    npm run css-build && \
    rm -rf assets/fonts_css

FROM nginx:latest

COPY --from=build-css  /usr/src/assets     /var/www/assets
COPY                   nginx/default.conf  /etc/nginx/conf.d/default.conf