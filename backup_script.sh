#!/bin/bash

# Script'in bulunduğu dizini belirleme
SCRIPT_DIR=$(dirname "$(realpath "$0")")

# Config dosyasının yolu
CONFIG_FILE="$SCRIPT_DIR/config.json"

# jq komutunun varlığını kontrol et
if ! command -v jq &> /dev/null; then
    echo "jq not found. Please install jq to parse JSON files."
    exit 1
fi

# Config dosyasından kaynak ve hedef dizinlerini okuma
SOURCE_PATH=$(jq -r '.source_path' "$CONFIG_FILE")
DESTINATION_PATH=$(jq -r '.destination_path' "$CONFIG_FILE")

# Yedekleme dizini oluşturma
BACKUP_DIR="$DESTINATION_PATH/backup"
mkdir -p "$BACKUP_DIR"

# Mevcut zamanı yedekleme dosyası adı olarak ayarlama
CURRENT_TIME=$(date +"%Y-%m-%d_%H-%M-%S")
TAR_FILE_NAME="${CURRENT_TIME}.tar"

# Kaynak dizini sıkıştırarak yedekleme yapma
tar -cvf "$BACKUP_DIR/$TAR_FILE_NAME" -C "$SOURCE_PATH" .

echo "Backup created: $BACKUP_DIR/$TAR_FILE_NAME"

# 30 günden eski yedekleri silme
find "$BACKUP_DIR" -type f -name "*.tar" -mtime +30 -exec rm -f {} \;

echo "Old backups deleted (older than 30 days)."