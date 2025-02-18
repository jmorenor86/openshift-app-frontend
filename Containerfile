    # Stage 1: Build the application
    FROM node:20-slim AS build

    WORKDIR /app

    COPY package*.json ./

    RUN npm install --legacy-peer-deps
    COPY next.config.ts ./
    COPY public ./public
    COPY src ./src
    COPY tailwind.config.ts ./tailwind.config.ts
    COPY postcss.config.mjs ./postcss.config.mjs

    RUN npm run build

    FROM node:20-slim AS production
    WORKDIR /app

    COPY --from=build /app/package*.json ./
    COPY --from=build /app/.next ./.next
    COPY --from=build /app/public ./public
    COPY --from=build /app/tailwind.config.ts ./tailwind.config.ts
    COPY --from=build /app/postcss.config.mjs ./postcss.config.mjs

    RUN npm install --production --legacy-peer-deps
    RUN rm -rf /root/.npm /app/src /app/tests /app/.git

    EXPOSE 3000

    CMD ["npm", "start"]
