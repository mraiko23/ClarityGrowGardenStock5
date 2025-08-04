#!/usr/bin/env bash
# render-build.sh
set -e

# Install dependencies
npm install

# Install Chrome
npx puppeteer browsers install chrome

# Ensure Chrome binary is executable
CHROME_DIR="/opt/render/.cache/puppeteer/chrome"
if [ -d "$CHROME_DIR" ]; then
  find "$CHROME_DIR" -type f -name "chrome" -exec chmod +x {} \;
fi
