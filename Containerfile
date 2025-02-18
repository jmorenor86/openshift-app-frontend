# Stage 1: Build the application
FROM node:20-slim AS build

# Set the working directory
WORKDIR /app

# Install necessary dependencies (including dev dependencies like ts-node)
COPY package*.json ./

RUN npm install --legacy-peer-deps

# Install ts-node to handle TypeScript configuration
RUN npm install ts-node --save-dev

# Copy application files
COPY next.config.ts ./
COPY public ./public
COPY src ./src
COPY tailwind.config.ts ./tailwind.config.ts
COPY postcss.config.mjs ./postcss.config.mjs

# Build the Next.js app
RUN npm run build

# Stage 2: Production image
FROM node:20-slim AS production

# Set the working directory
WORKDIR /app

# Copy necessary files from the build stage
COPY --from=build /app/package*.json ./
COPY --from=build /app/.next ./.next
COPY --from=build /app/public ./public
COPY --from=build /app/tailwind.config.ts ./tailwind.config.ts
COPY --from=build /app/postcss.config.mjs ./postcss.config.mjs

# Install only production dependencies
RUN npm install --production --legacy-peer-deps

# Clean up unnecessary files after install
RUN rm -rf /root/.npm /app/src /app/tests /app/.git

# Expose the port the app will run on
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
