#!/usr/bin/env bash

# أوقف السكربت إذا حصل أي خطأ
set -o errexit

echo ">> تثبيت التبعيات"
npm install
npx @puppeteer/browsers install chrome@136.0.7103.92

# فك التعليق إذا كان مشروعك يحتاج بناء بعد التثبيت
# echo ">> بناء المشروع"
# npm run build

# إعداد مسار كاش Puppeteer
PUPPETEER_CACHE_DIR=/opt/render/.cache/puppeteer
mkdir -p $PUPPETEER_CACHE_DIR


echo ">> تثبيت Chrome الخاص بـ Puppeteer"
#npx puppeteer browsers install chrome

if [[ ! -d $PUPPETEER_CACHE_DIR ]]; then
echo "...Copying Puppeteer Cache from Build Cache"
# Copying from the actual path where Puppeteer stores its Chrome binary
cp -R /opt/render/project/src/chrome/linux-136.0.7103.92/chrome-linux64/chrome/ $PUPPETEER_CACHE_DIR
else
echo "...Storing Puppeteer Cache in Build Cache"
cp -R $PUPPETEER_CACHE_DIR /opt/render/project/src/chrome/linux-136.0.7103.92/chrome-linux64/chrome/
fi
