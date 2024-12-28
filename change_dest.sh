#!/bin/bash

CONFIG_FILE="config.json"

if ! command -v jq &> /dev/null; then
    echo "Error: 'jq' is not installed. Please install jq to proceed."
    exit 1
fi

read -rp "Enter new destination path: " NEW_DESTINATION_PATH

if jq -e '.destination_path' "$CONFIG_FILE" > /dev/null; then
    jq --arg newPath "$NEW_DESTINATION_PATH" '.destination_path = $newPath' "$CONFIG_FILE" > temp.json && mv temp.json "$CONFIG_FILE"
    echo "destination_path '$NEW_DESTINATION_PATH' olarak güncellendi."
else
    echo "Error: 'destination_path' key not found in $CONFIG_FILE"
    exit 1
fi