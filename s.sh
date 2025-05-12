#!/usr/bin/env bash

# إيقاف السكربت عند أي خطأ
set -o errexit

echo ">> تثبيت التبعيات"
npm install

# تثبيت Chrome عبر Puppeteer
echo ">> تحميل Chrome المناسب"
npx @puppeteer/browsers install chrome@136.0.7103.92

# إعداد مسارات الكاش
PUPPETEER_CACHE_DIR="/opt/render/.cache/puppeteer"
TARGET_CACHE_COPY_DIR="/opt/render/project/src/chrome-cache"

# التأكد من وجود مجلد الكاش
mkdir -p "$PUPPETEER_CACHE_DIR"
mkdir -p "$TARGET_CACHE_COPY_DIR"

echo ">> البحث عن مجلد Chrome داخل كاش Puppeteer..."
if [[ -d "$PUPPETEER_CACHE_DIR/chrome" ]]; then
  echo "✅ تم العثور على Chrome في: $PUPPETEER_CACHE_DIR/chrome"
  echo "...نسخ كاش Puppeteer إلى مجلد المشروع"
  
  # نسخ المحتوى بدون نسخ مجلد داخل نفسه
  cp -R "$PUPPETEER_CACHE_DIR/chrome" "$TARGET_CACHE_COPY_DIR"
else
  echo "❌ لم يتم العثور على مجلد chrome داخل كاش Puppeteer"
fi

# 👇 فك التعليق لو تحتاج بناء مشروع بعد التثبيت
# echo ">> بناء المشروع"
# npm run build

echo "✅ السكربت انتهى بنجاح"
