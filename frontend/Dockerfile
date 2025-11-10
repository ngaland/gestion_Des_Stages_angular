# Build stage
FROM node:18-alpine AS build
WORKDIR /app

# Install Angular CLI globally
RUN npm install -g @angular/cli

# Install dependencies
COPY package*.json ./
RUN npm install --legacy-peer-deps

# Copy source and build
COPY . .
RUN ng build --configuration docker

# Runtime stage
FROM nginx:alpine

# Remove default nginx files
RUN rm -rf /usr/share/nginx/html/*

# Copy built Angular app
RUN mkdir -p /usr/share/nginx/html
COPY --from=build /app/dist/frontend/browser /tmp/browser
RUN cp -r /tmp/browser/* /usr/share/nginx/html/ && rm -rf /tmp/browser

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]