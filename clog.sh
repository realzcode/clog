#!/bin/sh

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

if [ "$choice" = "Y" ] || [ "$choice" = "y" ]; then

	echo "Starting log clearing process..."
	echo "--------------------------------"

	find "$log_directory" -type f -name "*log*" | while read -r log_file; do
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

	cat /dev/null > /var/log/utmp 
	echo "Clearing... /var/log/utmp [done]"

	cat /dev/null > /var/log/wtmp
	echo "Clearing... /var/log/wtmp [done]"

	cat /dev/null > /var/log/btmp
	echo "Clearing... /var/log/btmp [done]"

	rm -rf /var/log/journal/*
	echo "Clearing... journalctl [done]"

	cat /dev/null > "$HOME/.bash_history"
	bash -c "history -c"
	echo "Clearing... bash_history [done]"

	cat /dev/null > "$HOME/.zsh_history"
	bash -c "history -p"
	echo "Clearing... zsh_history [done]"

	echo "-------------------------------"
	echo "Log clearing process completed."

else
    echo "Bye :p"
fi
