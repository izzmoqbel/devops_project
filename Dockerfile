FROM node:22

# Create a non-root user
RUN useradd -m appuser

WORKDIR /app

COPY package*.json ./

RUN npm install

# Install dependencies using npm ci for reproducible builds
RUN npm ci --only=production


COPY . .

# Switch to the non-root user
USER appuser


EXPOSE 3000

CMD ["node", "index.js"]


