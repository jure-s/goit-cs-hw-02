LOG_FILE="website_status.log"
SITES=(
  "https://google.com"
  "https://github.com"
  "https://facebook.com"
  "https://nonexistent.website"
)

echo "=== Перевірка сайтів: $(date '+%Y-%m-%d %H:%M:%S') ===" >> "$LOG_FILE"

for SITE in "${SITES[@]}"; do
  STATUS=$(curl -Is --max-time 5 "$SITE" | head -n 1)
  if [[ $STATUS == *"200"* ]]; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $SITE -> ✅ OK ($STATUS)" | tee -a "$LOG_FILE"
  else
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $SITE -> ❌ ERROR ($STATUS)" | tee -a "$LOG_FILE"
  fi
done

echo "" >> "$LOG_FILE"
