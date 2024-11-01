#!/bin/bash
dir=$1
backupdir=$2
interval_secs=$3
max_backups=$4
mkdir -p "$backupdir"
ls -lR "$dir" > "$backupdir/directory-info.last"
backup_timestamp=$(date +'%Y-%m-%d-%H-%M-%S')
cp -r "$dir" "$backupdir/$backup_timestamp"
echo "Backup directory is ready: $backupdir"
echo "Backup created at $backupdir/$backup_timestamp"

while true; do
    sleep "$interval_secs"
    ls -lR "$dir" > "$backupdir/directory-info.new"
    
    if ! cmp -s "$backupdir/directory-info.last" "$backupdir/directory-info.new"; then
        echo "Backup directory is ready: $backupdir"
        backup_timestamp=$(date +'%Y-%m-%d-%H-%M-%S')
        echo "Backup created at $backupdir/$backup_timestamp"
        cp -r "$dir" "$backupdir/$backup_timestamp"
        mv "$backupdir/directory-info.new" "$backupdir/directory-info.last"

        # Use grep to filter out the backup info files when counting backups
        backups_number=$(ls -1 "$backupdir" | grep -v "directory-info" | wc -l)
        echo "Number of backups: $backups_number"

        if [ "$backups_number" -gt "$max_backups" ]; then 
            oldest_one=$(ls -1t "$backupdir" | grep -v "directory-info" | tail -n 1) 
            rm -r "$backupdir/$oldest_one" 
        fi
    else
        rm "$backupdir/directory-info.new" 
    fi
done
