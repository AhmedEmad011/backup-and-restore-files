overview
backupd.sh: A script that automates the process of backing up a directory at regular intervals. It monitors a source directory and creates timestamped backups in a specified backup directory.

restore.sh: A script that allows users to navigate through and restore different versions of their backed-up data.

Makefile for running the backup script easily, along with a pre-build step that creates the destination backup directory if it doesn't exist.

folder structure
backupd.sh  Main script for backing up the directory
restore.sh  Script for restoring from backups
Makefile    Makefile to automate backup process
backups/    Directory where backups are stored (created by script)
README.md   Documentation for the project

prerequisites 
bash 
Makefile required to install by command (sudo apt install make) 


instructions for Running the Backup Script (backupd.sh)

Make the script executable:
chmod +x backupd.sh
Run the backup script:

./backup.sh <source> <backup_directory> <interval_seconds> <max_backups>
Replace <source_directory> with the path of the directory to back up.
Replace <backup_directory> with the path where backups will be saved.
Replace <interval_seconds> with the time to wait between backups 
Replace <max_backups> with the maximum number of backups to keep.


Instructions for Restoring from Backups (restore.sh)

Make the restore script executable:
chmod +x restore.sh

Run the restore script:
./restore.sh <source_directory> <backup_directory>
Replace <source_directory> with the path of the directory to restore.
Replace <backup_directory> with the path where backups are stored.

Restoration Options:
Press 1 to restore to the previous backup.
Press 2 to restore to the next available backup.
Press 3 to exit the restoration process.


Makefile Usage (EASY WAY TO RUN THE TWO SCRIPTS)
You can also use the Makefile to automate the execution of the backup script with the following commands:
make (run + the script name with out .sh)
ex run_backup


