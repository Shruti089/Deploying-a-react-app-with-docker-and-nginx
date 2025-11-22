#STAGE 1
FROM node:25.1 AS build
WORKDIR /app
COPY package*.json .
RUN npm install
COPY . .
RUN npm run build

#STAGE 2 - Production Deployment
FROM nginx:alpine
COPY --from=build /app/dist /share/nginx/html
EXPOSE 80
CMD ["nginx","-g","daemon off;"]