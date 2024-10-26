FROM node:22 AS builder

# Create a non-root user
# RUN useradd -m appuser

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

# Switch to the non-root user
# USER appuser



FROM gcr.io/distroless/nodejs22-debian12


USER nonroot


COPY --from=builder --chown=nonroot:nonroot /app/index.js /
COPY --from=builder --chown=nonroot:nonroot /app /app
COPY --from=builder /app .

# Set the user to run the application
USER nonroot

# Set the working directory for the application
WORKDIR /app

EXPOSE 3000

CMD ["node", "index.js"]






