FROM node:alpine as builder
Workdir '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run builder

FROM nginx
#this expose port is mainly for AWS elastibeanstalk deployment. 
#it will look for this port
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
