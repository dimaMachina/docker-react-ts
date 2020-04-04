# tag phase with name `builder`
FROM node:alpine AS builder

WORKDIR /app
COPY package.json .
RUN npm i

COPY . .
RUN npm run build

FROM nginx
# expose 80 port for ElasticBeanstalck
EXPOSE 80
# copy `/app/build` folder from `builder` phase to nginx directory
COPY --from=builder /app/build /usr/share/nginx/html

# default command of nginx container will start server
# `docker build -t <tag name> .`
