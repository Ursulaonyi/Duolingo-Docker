# Use Node.js image
FROM node:18-alpine3.21 AS builder

# Set working directory
WORKDIR /app

# Install dependencies
COPY package*.json ./

RUN npm cache clean --force
RUN npm config set registry https://registry.npmjs.org/

RUN npm install

# Copy all app files
COPY . .

RUN npm run build

FROM node:18-alpine3.21

WORKDIR /app

COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/next.config.mjs ./
COPY --from=builder /app/.env ./

# Install optional dev dependencies (optional)
RUN npm install --omit=dev

# Expose port
EXPOSE 3000

# Start the dev server
CMD ["npm", "start"]
