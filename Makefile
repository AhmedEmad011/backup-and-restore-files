# Define the directories and scripts
DIR=source
BACKUPDIR=dist
BACKUP_SCRIPT=backup.sh
RESTORE_SCRIPT=restore.sh
INTERVAL=5       
MAX_BACKUPS=4     

# Default target
all: run_backup

# Pre-build step to ensure the backup directory exists
pre-build:
	@mkdir -p $(BACKUPDIR)
	@echo "Backup directory created or already exists."

# Target to run the backup script
run_backup: pre-build
	@bash $(BACKUP_SCRIPT) $(DIR) $(BACKUPDIR) $(INTERVAL) $(MAX_BACKUPS)

# Target to run the restore script
run_restore:
	@bash $(RESTORE_SCRIPT) $(DIR) $(BACKUPDIR)

# Clean target (if necessary)
clean:
	@rm -rf $(BACKUPDIR)
	@echo "Backup directory cleaned."

# Phony targets to avoid conflicts with actual files
.PHONY: all pre-build run_backup run_restore clean
