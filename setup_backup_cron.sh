#!/bin/bash

# Script'in bulunduğu dizini belirle
SCRIPT_DIR=$(dirname "$(realpath "$0")")
SCRIPT_PATH="$SCRIPT_DIR/backup_script.sh"
LOG_FILE="$SCRIPT_DIR/backup_cron.log"

# Cron job için gerekli komut
CRON_COMMAND="0 0 * * * /bin/bash $SCRIPT_PATH >> $LOG_FILE 2>&1"

# crontab'da cron job zaten var mı kontrol et
if crontab -l 2>/dev/null | grep -F "$CRON_COMMAND" > /dev/null; then
    echo "Cron job already exists. No changes made."
else
    # Cron job ekle
    (crontab -l 2>/dev/null; echo "$CRON_COMMAND") | crontab -
    echo "Cron job added to run at midnight daily."
fi