#!/bin/bash

echo "
█▀▀ █░░ █▀█ █▀▀
█▄▄ █▄▄ █▄█ █▄█
by RealzCode
"

if [ "$(id -u)" -ne 0 ]; then
    printf "sudo ./clog.sh"
    exit 1
fi

log_directory="/var/log"

read -rp "Rock n Roll ? (Y/N): " choice

if [[ "$choice" =~ ^[Yy]$ ]]; then

	echo "Starting log clearing process..."
	echo "--------------------------------"

	find "$log_directory" -type f -name "*.log" | while read -r log_file; do
	    if [ -f "$log_file" ]; then
	        if [ -r "$log_file" ]; then
	            echo "Clearing... $log_file [done]"
	        else
	            echo "Error $log_file Permission Denied"
	        fi
	    else
	        echo "Error $log_file File not exists"
	    fi
	done

	rm -rf /var/log/journal/*
	echo "Clearing... journal [done]"

	cat /dev/null > "$HOME/.bash_history"
	history -c
	echo "Clearing... .bash_history [done]"

	cat /dev/null > "$HOME/.zsh_history"
	history -p
	echo "Clearing... .zsh_history [done]"

	echo "-------------------------------"
	echo "Log clearing process completed."

else
    echo "Bye :p"
fi
