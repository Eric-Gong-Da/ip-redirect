#!/bin/bash

REPO_DIR="/home/ubuntu/ip-redirect"
cd "$REPO_DIR" || exit 1

PUBLIC_IP=$(curl -s https://api.ipify.org)

if [ -z "$PUBLIC_IP" ]; then
    echo "Failed to get public IP"
    exit 1
fi

echo "Current public IP: $PUBLIC_IP"

cp index.html index.html.backup
sed "s|SERVER_IP_PLACEHOLDER|${PUBLIC_IP}|g" index.html.backup > index.html
rm index.html.backup

git config user.name "Auto Update Bot"
git config user.email "bot@auto-update.local"

git add index.html

if git diff --cached --quiet; then
    echo "No changes to commit"
    exit 0
fi

git commit -m "Update server IP to ${PUBLIC_IP}"

git push origin main --force

echo "Successfully updated GitHub Pages with IP: $PUBLIC_IP"
