#!/bin/bash

# Script'in bulunduğu dizini belirle
SCRIPT_DIR=$(dirname "$(realpath "$0")")

# Config dosyasının yolu (script'in olduğu dizinde)
CONFIG_FILE="$SCRIPT_DIR/config.json"

# jq kontrolü
if ! command -v jq &> /dev/null; then
    echo "jq not found. Please install jq to parse JSON files."
    exit 1
fi

# Kaynak ve hedef yolları config.json'dan oku
SOURCE_PATH=$(jq -r '.source_path' "$CONFIG_FILE")
DESTINATION_PATH=$(jq -r '.destination_path' "$CONFIG_FILE")

# Backup dizini
BACKUP_DIR="$DESTINATION_PATH/backup"
mkdir -p "$BACKUP_DIR"

# En son oluşturulan backup dosyasını kontrol et
LAST_BACKUP=$(find "$BACKUP_DIR" -type f -name "*.tar" -exec stat -f "%m %N" {} + | sort -n | tail -1 | cut -d ' ' -f 2)

# Eğer backup yoksa veya en son backup üzerinden 24 saat geçmişse yeni backup oluştur
if [ -z "$LAST_BACKUP" ] || [ $(($(date +%s) - $(stat -f %m "$LAST_BACKUP"))) -gt 86400 ]; then
    CURRENT_TIME=$(date +"%Y-%m-%d_%H-%M-%S")
    TAR_FILE_NAME="${CURRENT_TIME}.tar"

    tar -cvf "$BACKUP_DIR/$TAR_FILE_NAME" -C "$SOURCE_PATH" .

    echo "Backup created: $BACKUP_DIR/$TAR_FILE_NAME"
else
    echo "Last backup is less than 24 hours old. No new backup created."
fi

# 30 günden eski yedekleri sil
find "$BACKUP_DIR" -type f -name "*.tar" -mtime +30 -exec rm -f {} \;

echo "Old backups deleted (older than 30 days)."