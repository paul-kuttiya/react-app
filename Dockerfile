# prod build image
FROM node:16-alpine as builder

WORKDIR /app

COPY package.json .
RUN npm install

COPY . .

RUN npm run build

# nginx
FROM nginx
# expose port to ELB
EXPOSE 80
# copy from above container to current nginx container
COPY --from=builder /app/build /usr/share/nginx/html
