FROM node:22 As builder 


WORKDIR /app


COPY package*.json ./

RUN npm install

COPY . .

FROM gcr.io/distroless/nodejs22-debian12

WORKDIR /app

COPY --from=builder --chown=nonroot:nonroot /app/index.js ./
COPY --from=builder --chown=nonroot:nonroot /app/node_modules ./node_modules

USER nonroot

EXPOSE 3000

CMD ["index.js"]