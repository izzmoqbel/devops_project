FROM node:22 AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

FROM gcr.io/distroless/nodejs22-debian12

USER nonroot

COPY --from=builder --chown=nonroot:nonroot /app/index.js /
COPY --from=builder --chown=nonroot:nonroot /app /app
COPY --from=builder /app .

USER nonroot

WORKDIR /app

EXPOSE 3000

CMD ["node", "index.js"]






