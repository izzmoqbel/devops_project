FROM node:22

# Create a non-root user
RUN useradd -m appuser

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .


# Change ownership of app files to the non-root user
RUN chown -R appuser:appuser /app

# Use the non-root user created
USER appuser


EXPOSE 3000

CMD ["node", "index.js"]



