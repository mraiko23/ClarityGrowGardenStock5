FROM node:20-slim

# Set Node.js environment variables
ENV NODE_ENV=production
ENV NODE_OPTIONS="--no-experimental-fetch"

# Install Chrome dependencies
RUN apt-get update \
    && apt-get install -y wget gnupg2 \
    && mkdir -p /etc/apt/keyrings \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor > /etc/apt/keyrings/google.gpg \
    && echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/google.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt-get install -y google-chrome-stable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1 \
      --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install app dependencies
RUN npm cache clean --force && \
    npm install

# Copy app source
COPY . .

# Expose port
EXPOSE 3000

# Start command
CMD ["node", "server.js"]
