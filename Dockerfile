FROM node:10-alpine as build-step
RUN mkdir -p /app
WORKDIR /app
COPY package.json /app
RUN npm install
COPY . /app
RUN npm run build --prod

FROM nginx:1.19.4-alpine
COPY ./nginx/default.conf.template /etc/nginx/templates/default.conf.template
COPY --from=build-step /app/dist/todo-front/ /usr/share/nginx/html