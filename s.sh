#!/bin/bash

echo ">> بدء تثبيت Chrome عبر Puppeteer"

# 1. تحديد مسار الكاش المطلوب
PUPPETEER_CACHE_DIR="/opt/render/.cache/puppeteer"
mkdir -p "$PUPPETEER_CACHE_DIR"

# 2. تثبيت Chrome بواسطة Puppeteer
npx @puppeteer/browsers install chrome@136.0.7103.92

# 3. البحث عن مجلد Chrome داخل كاش Puppeteer
echo ">> البحث عن مجلد Chrome داخل كاش Puppeteer..."
ACTUAL_CACHE=$(find $HOME -type d -path "*/puppeteer/chrome" 2>/dev/null | head -n 1)

if [[ -z "$ACTUAL_CACHE" ]]; then
  echo "❌ لم يتم العثور على مجلد Chrome الخاص بـ Puppeteer."
  exit 1
fi

echo "✅ تم العثور على Chrome في: $ACTUAL_CACHE"

# 4. إدارة الكاش بين مراحل البناء
if [[ ! -d "$PUPPETEER_CACHE_DIR" ]]; then
  echo "...نسخ كاش Puppeteer من مجلد المشروع إلى $PUPPETEER_CACHE_DIR"
  cp -R "$ACTUAL_CACHE" "$PUPPETEER_CACHE_DIR"
else
  echo "...حفظ كاش Puppeteer في مجلد المشروع"
  cp -R "$PUPPETEER_CACHE_DIR" "$ACTUAL_CACHE"
fi
