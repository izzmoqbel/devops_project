FROM node:23

# Create a non-root user
RUN useradd -m appuser

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

# Switch to the non-root user
USER appuser


EXPOSE 3000

CMD ["node", "index.js"]


