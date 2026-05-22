FROM node:20-alpine

WORKDIR /app

ENV NODE_ENV=production
ENV PORT=5000

COPY --chown=node:node webapp/backend/package*.json ./
RUN npm ci --omit=dev && npm cache clean --force

COPY --chown=node:node webapp/backend/server.js ./

USER node

EXPOSE 5000

CMD ["npm", "start"]
