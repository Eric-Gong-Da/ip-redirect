#!/bin/bash

REPO_DIR="/home/ubuntu/ip-redirect"
cd 

PUBLIC_IP=124.156.174.232

if [ -z "" ]; then
    PUBLIC_IP=124.156.174.232
fi

if [ -z "" ]; then
    echo "Failed to get public IP"
    exit 1
fi

echo "Current public IP: "

sed -i "s/SERVER_IP//g" index.html

git add index.html
if git commit -m "Update server IP to "; then
    git push -u origin main
else
    echo "No changes to commit"
fi
