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
TARGET_CACHE_DIR="/opt/render/.cache/puppeteer/chrome/linux-136.0.7103.92/chrome-linux64"
TARGET_CHROME_EXEC="/opt/render/.cache/puppeteer/chrome/linux-136.0.7103.92/chrome-linux64/chrome"

# التأكد من وجود مجلدات الكاش والمجلد الهدف
mkdir -p "$TARGET_CACHE_DIR"

echo ">> البحث عن مجلد Chrome داخل كاش Puppeteer..."
if [[ -d "$PUPPETEER_CACHE_DIR/chrome" ]]; then
  echo "✅ تم العثور على Chrome في: $PUPPETEER_CACHE_DIR/chrome"
  echo "...نسخ كاش Puppeteer إلى المجلد الهدف"

  # نسخ محتويات Chrome إلى المجلد الهدف
  cp -R "$PUPPETEER_CACHE_DIR/chrome" "$TARGET_CACHE_DIR"
  
  # التأكد من أن المسار النهائي للملف التنفيذي هو كما هو مطلوب
  echo ">> التأكد من أن Chrome موجود في المسار المطلوب"
  if [[ -f "$TARGET_CHROME_EXEC" ]]; then
    echo "✅ تم العثور على Chrome في المسار المطلوب: $TARGET_CHROME_EXEC"
  else
    echo "❌ لم يتم العثور على Chrome في المسار المطلوب"
  fi
else
  echo "❌ لم يتم العثور على مجلد chrome داخل كاش Puppeteer"
fi

# 👇 فك التعليق لو تحتاج بناء مشروع بعد التثبيت
# echo ">> بناء المشروع"
# npm run build

echo "✅ السكربت انتهى بنجاح"
