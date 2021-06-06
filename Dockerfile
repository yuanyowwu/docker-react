FROM node:alpine
# FROM node:alpine as builder 
# the above doesn't work well with AWS
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
 
FROM nginx
COPY --from=0 /app/build /usr/share/nginx/html
## COPY --from=builder /app/build /usr/share/nginx/html 
## this is what we would used 

## no RUN nginx since the default behaviour of the
# container is to run the nginx server