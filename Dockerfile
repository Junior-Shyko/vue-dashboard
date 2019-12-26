# develop stage
#https://medium.com/@jwdobken/vue-with-docker-initialize-develop-and-build-51fad21ad5e6
FROM node:11.1-alpine as develop-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
# build stage
FROM develop-stage as build-stage
#RUN npm run serve
RUN yarn build
# production stage
FROM nginx:1.15.7-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
#EXPOSE 8080
#CMD [ "http-server", "dist" ]