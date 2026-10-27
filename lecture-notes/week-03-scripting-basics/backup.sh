#!/bin/bash
# Bash: simple backup automation
set -euo pipefail
SRC="$HOME/infra-automation-course"
DEST="$HOME/backups"
mkdir -p "$DEST"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
tar -czf "$DEST/backup_$TIMESTAMP.tar.gz" "$SRC" \
  && echo "Backup succeeded: $TIMESTAMP" >> backup.log \
  || echo "Backup FAILED: $TIMESTAMP" >> backup.log
