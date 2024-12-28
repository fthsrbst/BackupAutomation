#!/bin/bash

# config.json dosyasının yolu
CONFIG_FILE="config.json"

# Eğer jq yüklü değilse hata ver
if ! command -v jq &> /dev/null; then
    echo "Error: 'jq' is not installed. Please install jq to proceed."
    exit 1
fi

# Kullanıcıdan yeni source_path değerini al
read -rp "Enter new source path: " NEW_SOURCE_PATH

# source_path anahtarı var mı kontrol et ve güncelle
if jq -e '.source_path' "$CONFIG_FILE" > /dev/null; then
    jq --arg newPath "$NEW_SOURCE_PATH" '.source_path = $newPath' "$CONFIG_FILE" > temp.json && mv temp.json "$CONFIG_FILE"
    echo "source_path '$NEW_SOURCE_PATH' olarak güncellendi."
else
    echo "Error: 'source_path' key not found in $CONFIG_FILE"
    exit 1
fi