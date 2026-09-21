#!/bin/bash
set -e

date
echo "Updating Python application on VM..."

APP_DIR="/home/azureuser/AzureCICD"
BRANCH="main"

git config --global --add safe.directory "$APP_DIR"

if [ ! -d "$APP_DIR/.git" ]; then
    echo "Repository not found at $APP_DIR"
    exit 1
fi

cd "$APP_DIR"
git pull origin "$BRANCH"

"$APP_DIR/venv/bin/pip" install --upgrade pip
"$APP_DIR/venv/bin/pip" install -r "$APP_DIR/requirements.txt"

sudo systemctl restart myapp

echo "Python application update completed!"