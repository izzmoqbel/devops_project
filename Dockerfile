FROM node:22 AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

FROM gcr.io/distroless/nodejs22-debian12

WORKDIR /app

COPY --from=builder --chown=nonroot:nonroot /app/index.js /

USER nonroot


EXPOSE 3000

CMD ["node", "index.js"]
