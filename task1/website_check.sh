# ========================================
# Скрипт перевіряє доступність вебсайтів
# ========================================

LOG_FILE="website_status.log"
SITES=(
  "https://google.com"
  "https://github.com"
  "https://facebook.com"
  "https://nonexistent.website"
)

echo "=== Перевірка сайтів: $(date '+%Y-%m-%d %H:%M:%S') ===" >> "$LOG_FILE"

for SITE in "${SITES[@]}"; do
  # -L слідує редіректам; -s тихий режим; -o /dev/null (тіло не потрібно); -w тільки код
  CODE=$(curl -Ls -o /dev/null -w "%{http_code}" --max-time 10 "$SITE")
  if [[ "$CODE" == "200" ]]; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $SITE is UP" | tee -a "$LOG_FILE"
  else
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $SITE is DOWN (HTTP $CODE)" | tee -a "$LOG_FILE"
  fi
done

echo "Results saved to $LOG_FILE"
echo "" >> "$LOG_FILE"
