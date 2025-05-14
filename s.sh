#!/usr/bin/env bash
set -o errexit  # Exit on errors

# 1. تثبيت التبعيات
npm install

# 2. (اختياري) بناء المشروع
# npm run build

# 3. إعداد مسارات الكاش
GLOBAL_CACHE=/opt/render/.cache/puppeteer
PROJECT_CACHE=/opt/render/project/src/.cache/puppeteer

mkdir -p "$GLOBAL_CACHE"
mkdir -p "$PROJECT_CACHE"

# 4. إذا كان لديك نسخة محفوظة سابقاً في كاش المشروع، انسخها إلى الكاش العام
if [ -d "$PROJECT_CACHE/chrome" ]; then
  echo "...Copying existing Chrome from project cache to global cache"
  cp -R "$PROJECT_CACHE/chrome" "$GLOBAL_CACHE"
fi

# 5. تأكد من تنزيل Chrome عبر Puppeteer
echo "...Installing Chrome via Puppeteer"
npx puppeteer browsers install chrome

# 6. بعد التنزيل، احفظ النسخة في كاش المشروع للاستفادة منها في البنيات القادمة
echo "...Saving Chrome from global cache back to project cache"
rm -rf "$PROJECT_CACHE/chrome"            # نظّف القديم (إن وُجد)
cp -R "$GLOBAL_CACHE/chrome" "$PROJECT_CACHE"

echo "✅ Puppeteer & Chrome are installed and cached successfully."
