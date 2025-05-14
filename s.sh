#!/usr/bin/env bash
# Exit immediately if a command exits with a non-zero status
set -o errexit

# Install dependencies
npm install

# Uncomment this line if you need to build your project
# npm run build

# Ensure the global Puppeteer cache directory exists
PUPPETEER_CACHE_DIR=/opt/render/.cache/puppeteer
mkdir -p "$PUPPETEER_CACHE_DIR"

# Install Puppeteer and download Chrome
npx puppeteer browsers install chrome

# Prepare project-local cache directory for Puppeteer Chrome binary
PROJECT_CACHE_DIR=/opt/render/project/src/.cache/puppeteer/chrome
mkdir -p "$PROJECT_CACHE_DIR"

# Store/pull Puppeteer cache with build cache
if [[ ! -d "$PUPPETEER_CACHE_DIR" ]]; then
  echo "...Copying Puppeteer Cache from Build Cache"
  cp -R "$PROJECT_CACHE_DIR" "$PUPPETEER_CACHE_DIR"
else
  echo "...Storing Puppeteer Cache in Build Cache"
  cp -R "$PUPPETEER_CACHE_DIR" "$PROJECT_CACHE_DIR"
fi
