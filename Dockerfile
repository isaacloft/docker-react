# build phrase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
# this isnt needed as docker compose also specifies a locally mapping for volume
COPY . .
CMD ["npm","run","build"]

# run phrase
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
 
# run the nginx server
# d run -p 8080:80 <image id>