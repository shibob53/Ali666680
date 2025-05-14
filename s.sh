#!/usr/bin/env bash
set -o errexit

# 1. تثبيت التبعيات
npm install

# 2. (اختياري) بناء المشروع
# npm run build

# 3. إعداد مسارات الكاش
export PUPPETEER_CACHE_DIR=/opt/render/.cache/puppeteer
PROJECT_CACHE=/opt/render/project/src/.cache/puppeteer
mkdir -p "$PUPPETEER_CACHE_DIR" "$PROJECT_CACHE"

# 4. نسخ كاش سابق (إن وُجد) لتسريع التنزيل
if [ -d "$PROJECT_CACHE/chrome" ]; then
  echo "...Copying existing Chrome from project cache to global cache"
  cp -R "$PROJECT_CACHE/chrome" "$PUPPETEER_CACHE_DIR"
fi

# 5. تنزيل كروم عبر Puppeteer
echo "...Installing Chrome via Puppeteer"
npx puppeteer browsers install chrome

# 6. حفظ كروم في كاش المشروع
echo "...Saving Chrome from global cache back to project cache"
rm -rf "$PROJECT_CACHE/chrome"
cp -R "$PUPPETEER_CACHE_DIR/chrome" "$PROJECT_CACHE"

# 7. تعيين مسار التنفيذ حتى يكتشفه Puppeteer-Core
export PUPPETEER_EXECUTABLE_PATH="$PUPPETEER_CACHE_DIR/chrome/linux-136.0.7103.92/chrome-linux64/chrome"

echo "✅ Puppeteer & Chrome are installed, cached, and executable path is set."
