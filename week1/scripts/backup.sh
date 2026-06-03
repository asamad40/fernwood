#!/bin/bash
set -euo pipefail

# Configuration
SOURCE_DIR="$HOME/fernwood"
BACKUP_DIR="$HOME/backups"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_NAME="backup_$DATE"
LOG_FILE="$HOME/fernwood/week1/logs/backup.log"

# Cleanup backups older than 7 days
cleanup() {
    echo "[$DATE] Cleaning up backups older than 7 days..." | tee -a "$LOG_FILE"
    find "$BACKUP_DIR" -maxdepth 1 -name "backup_*" -mtime +7 -exec rm -rf {} \;
    echo "[$DATE] Cleanup done." | tee -a "$LOG_FILE"
}

# Run incremental backup
run_backup() {
    echo "[$DATE] Starting backup of $SOURCE_DIR..." | tee -a "$LOG_FILE"

    # Create backup directory if it doesn't exist
    mkdir -p "$BACKUP_DIR/$BACKUP_NAME"

    # Use rsync for incremental backup
    rsync -av --update "$SOURCE_DIR/" "$BACKUP_DIR/$BACKUP_NAME/" | tee -a "$LOG_FILE"

    echo "[$DATE] Backup completed: $BACKUP_DIR/$BACKUP_NAME" | tee -a "$LOG_FILE"
}

# Main function
main() {
    mkdir -p "$BACKUP_DIR"
    mkdir -p "$(dirname "$LOG_FILE")"
    run_backup
    cleanup
    echo "[$DATE] All done." | tee -a "$LOG_FILE"
}

main "$@"
