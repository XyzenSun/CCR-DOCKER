FROM node:22-alpine3.22 AS builder
WORKDIR /app
COPY package.json .
RUN npm install --omit=dev

FROM alpine:3.22

RUN apk add --no-cache nodejs

WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules

COPY entrypoint.js .

ENV STREAM_LOG_FILE=false
EXPOSE 3456

ENTRYPOINT ["node", "entrypoint.js"]
