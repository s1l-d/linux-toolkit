#!/bin/bash
# Бэкап с ротацией: храним последние N дней
# Использование: sudo ./backup.sh [что_бэкапить] [куда_класть]

set -euo pipefail

SRC="${1:-/etc}"
DEST="${2:-/var/backups/myserver}"
KEEP_DAYS=7
DATE="$(date +%Y%m%d_%H%M)"
ARCHIVE="$DEST/backup-$DATE.tar.gz"

echo "[INFO] Старт бэкапа: $SRC -> $ARCHIVE"
mkdir -p "$DEST"
tar -czf "$ARCHIVE" "$SRC"
echo "[INFO] Создан: $(du -h "$ARCHIVE" | cut -f1)"

echo "[INFO] Удаляю бэкапы старше $KEEP_DAYS дней"
find "$DEST" -name "backup-*.tar.gz" -mtime +"$KEEP_DAYS" -delete

echo "[OK] Бэкап завершён"