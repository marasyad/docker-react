#as builder indentifying the phase as builder
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install 
COPY . .
#making build version of the app to be deployed in the production
#all output file of npm run build will be written in build folder at the destination directory
RUN npm run build

FROM nginx
# --from copying file from another phase, the destination /usr/share/nginx/html is directory of static program that will be deployed by nginx
COPY --from=builder /app/build /usr/share/nginx/html  