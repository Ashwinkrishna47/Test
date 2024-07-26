bash
#!/bin/bash

# Source directory to be backed up
SOURCE_DIR="/path/to/source/directory"

# Destination server details
DEST_USER="your_username"
DEST_HOST="your_remote_server_ip"
DEST_DIR="/path/to/remote/backup/directory"

# Log file
LOG_FILE="/var/log/backup.log"

# Run the backup using SCP
scp -r "$SOURCE_DIR" "$DEST_USER@$DEST_HOST:$DEST_DIR" >> "$LOG_FILE" 2>&1

# Check the exit status
if [ $? -eq 0 ]; then
  echo "$(date) - Backup successful!" >> "$LOG_FILE"
else
  echo "$(date) - Backup failed." >> "$LOG_FILE"
  exit 1
fi

# Set up cron job to run daily at 2am
(crontab -l ; echo "0 2 * * * /path/to/this/script.sh") | crontab -
