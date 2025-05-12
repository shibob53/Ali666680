#!/usr/bin/env bash

# أوقف السكربت إذا حصل أي خطأ
set -o errexit

echo ">> تثبيت التبعيات"
npm install

# فك التعليق إذا كان مشروعك يحتاج بناء بعد التثبيت
# echo ">> بناء المشروع"
# npm run build

# إعداد مسار كاش Puppeteer
PUPPETEER_CACHE_DIR="/opt/render/.cache/puppeteer"
echo ">> التأكد من وجود مجلد الكاش: $PUPPETEER_CACHE_DIR"
mkdir -p "$PUPPETEER_CACHE_DIR"

echo ">> تثبيت Chrome الخاص بـ Puppeteer"
#npx puppeteer browsers install chrome
npx @puppeteer/browsers install chrome@136.0.7103.92

# نقل أو نسخ الكاش بين build cache و Puppeteer cache
if [[ ! -d "$PUPPETEER_CACHE_DIR" ]]; then
  echo ">> نسخ كاش Puppeteer من build cache"
  cp -R /opt/render/project/src/chrome/linux-136.0.7103.92/chrome-linux64/chrome "$PUPPETEER_CACHE_DIR"
else
  echo ">> حفظ كاش Puppeteer في build cache"
  mkdir -p /opt/render/project/src/chrome/linux-136.0.7103.92/chrome-linux64/chrome
  cp -R "$PUPPETEER_CACHE_DIR" /opt/render/project/src/chrome/linux-136.0.7103.92/chrome-linux64/chrome
fi
