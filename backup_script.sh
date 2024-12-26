#!/bin/bash


CONFIG_FILE="config.json"
SOURCE_PATH=$(jq -r '.source_path' "$CONFIG_FILE")
DESTINATION_PATH=$(jq -r '.destination_path' "$CONFIG_FILE")

# Eğer jq yüklü değilse hata ver
if ! command -v jq &> /dev/null; then
    echo "jq not found. Please install jq to parse JSON files."
    exit 1
fi


BACKUP_DIR="$DESTINATION_PATH/backup"
mkdir -p "$BACKUP_DIR"


CURRENT_TIME=$(date +"%Y-%m-%d_%H-%M-%S")
TAR_FILE_NAME="${CURRENT_TIME}.tar"


tar -cvf "$BACKUP_DIR/$TAR_FILE_NAME" -C "$SOURCE_PATH" .


find "$BACKUP_DIR" -type f -name "*.tar" -mtime +30 -exec rm -f {} \;


echo "Backup created: $BACKUP_DIR/$TAR_FILE_NAME"
echo "Old backups deleted (older than 30 days)."