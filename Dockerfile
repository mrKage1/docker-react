# A 'build' container part:
FROM node:alpine as builder
WORKDIR '/opt/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
# all built content will (that we will use in prod) be in /opt/app/build


# A 'prod web' container part:
FROM nginx
COPY --from=builder /opt/app/build /usr/share/nginx/html

