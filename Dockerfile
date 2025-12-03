# Use official Node.js LTS image
FROM node:18-alpine

# Create app directory
WORKDIR /app

# Install dependencies first (leverage Docker layer caching)
COPY package.json package-lock.json* ./
RUN npm ci --omit=dev || npm install --omit=dev

# Bundle app source
COPY . .

# Set production env
ENV NODE_ENV=production

# Wasmer/containers typically inject PORT; default to 8080 if not set
ENV PORT=8080
EXPOSE 8080

# Start the server
CMD ["node", "server.js"]
