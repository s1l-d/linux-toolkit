#!/bin/bash
# Диагностика сети: снизу вверх по слоям OSI
# Использование: ./network-diag.sh [домен]

DOMAIN="${1:-github.com}"

echo "=== Диагностика сети для $DOMAIN ==="
echo ""

GW=$(ip route | grep default | awk '{print $3}')
echo "[1/5] Пинг шлюза ($GW):"
if ping -c 2 -W 2 "$GW" >/dev/null 2>&1; then echo "  OK"; else echo "  FAIL"; fi

echo "[2/5] Пинг 8.8.8.8 (интернет без DNS):"
if ping -c 2 -W 2 8.8.8.8 >/dev/null 2>&1; then echo "  OK"; else echo "  FAIL"; fi

echo "[3/5] DNS-резолвинг $DOMAIN:"
IP=$(dig +short "$DOMAIN" | head -n 1)
if [ -n "$IP" ]; then echo "  OK: $IP"; else echo "  FAIL"; fi

echo "[4/5] Порт 443 на $DOMAIN:"
if nc -z -w 3 "$DOMAIN" 443 2>/dev/null; then echo "  OK"; else echo "  FAIL"; fi

echo "[5/5] HTTP-ответ:"
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" -m 5 "https://$DOMAIN")
if [ "$HTTP_CODE" = "200" ]; then echo "  OK: HTTP $HTTP_CODE"; else echo "  FAIL: HTTP $HTTP_CODE"; fi
