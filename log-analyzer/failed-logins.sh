#!/bin/bash
# Отчёт о неудачных попытках входа на сервер

echo "=== ТОП-10 IP с неудачными попытками входа ==="
sudo lastb 2>/dev/null | awk '{print $3}' | grep -E '^[0-9]+\.' | sort | uniq -c | sort -rn | head -10

echo ""
echo "=== Неудачных попыток за 24 часа ==="
sudo journalctl -u ssh --since "1 day ago" 2>/dev/null | grep -c "Failed password"

echo ""
echo "=== Активные сессии ==="
w
