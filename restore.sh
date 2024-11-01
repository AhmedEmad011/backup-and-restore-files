#!/bin/bash

dir=$1
backupdir=$2

if [ ! -d "$dir" ]; then
    echo "Source directory does not exist."
    exit 1
fi

if [ ! -d "$backupdir" ]; then
    echo "Backup directory does not exist."
    exit 1
fi
e
if [ -z "$(ls -A "$backupdir")" ]; then
    echo "No backups available."
    exit 1
fi

backups=($(ls -1 "$backupdir" | grep -v "directory-info"))
current=$((${#backups[@]} - 1)) 


echo "Available backups:"
for i in "${!backups[@]}"; do
    echo "$i: ${backups[$i]}"
done

while true; do
    echo "Enter your choice (1: Restore previous, 2: Restore next, 3: Exit):"
    read choice

    if [ "$choice" -eq 1 ]; then
        if [ "$current" -le 0 ]; then
            echo "No older backup available to restore."
        else
            current=$(($current - 1))
            rm -rf "$dir"/*  # Remove all contents of the source directory
            cp -r "$backupdir/${backups[$current]}"/* "$dir/"
            echo "Restored to the previous version: ${backups[$current]}"
        fi

    elif [ "$choice" -eq 2 ]; then
        if [ "$current" -ge $((${#backups[@]} - 1)) ]; then
            echo "No newer backup available to restore."
        else
            current=$(($current + 1))
            rm -rf "$dir"/*  
            cp -r "$backupdir/${backups[$current]}"/* "$dir/"
            echo "Restored to the next version: ${backups[$current]}"
        fi

    elif [ "$choice" -eq 3 ]; then
        echo "Exiting..."
        exit 0

    else
        echo "Invalid option. Please try again."
    fi
done
