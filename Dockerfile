# prod build image
FROM node:16-alpine as builder

WORKDIR /app

COPY package.json yarn.lock ./
RUN yarn

COPY . .

RUN yarn build

# nginx
FROM nginx
# copy from above container to current nginx container
COPY --from=builder /app/build /usr/share/nginx/html
