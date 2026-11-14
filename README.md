# Linux Toolkit 🐧

Набор скриптов и инструментов для администрирования Linux-серверов.
Создан в рамках обучения DevOps-инженерии.

## 📁 Структура

| Папка | Назначение |
|-------|------------|
| `scripts/` | Повседневные скрипты администратора |
| `log-analyzer/` | Анализ логов и безопасности |
| `.github/workflows/` | CI: shellcheck для всех скриптов |

## 🛠 Скрипты

### scripts/network-diag.sh
Диагностика сети по слоям OSI (5 проверок):
1. Пинг шлюза
2. Пинг 8.8.8.8 (интернет без DNS)
3. DNS-резолвинг
4. Проверка порта 443
5. HTTP-ответ

Использование:

    ./scripts/network-diag.sh github.com

### scripts/backup.sh
Бэкап с ротацией: хранит архивы за последние 7 дней.

Использование:

    sudo ./scripts/backup.sh /etc /var/backups/myserver

Пример cron (ежедневно в 02:00):

    0 2 * * * /opt/linux-toolkit/scripts/backup.sh /etc /var/backups/myserver >> /var/log/backup-cron.log 2>&1

### log-analyzer/failed-logins.sh
Отчёт о безопасности: ТОП IP с неудачными входами,
количество попыток за 24 часа, активные сессии.

Использование:

    sudo ./log-analyzer/failed-logins.sh

## 🎯 Технологии
- Bash (проверено shellcheck)
- systemd / journalctl
- iproute2, dig, nc, curl, tar, cron
- GitHub Actions (shellcheck CI)

## 👤 Автор
s1l-d — DevOps-инженер в обучении