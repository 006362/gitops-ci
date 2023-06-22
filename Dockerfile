FROM node:latest as Build

WORKDIR /app

COPY package.json /app
RUN npm install

COPY . /app

RUN npm run build

FROM nginx:1.23-alpine

WORKDIR /usr/share/nginx/html

COPY --from=Build /app/build ./

CMD [ "nginx", "-g", "daemon off;" ]