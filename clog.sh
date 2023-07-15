#!/bin/sh

echo "
█▀▀ █░░ █▀█ █▀▀
█▄▄ █▄▄ █▄█ █▄█
by RealzCode
"

if [ "$(id -u)" -ne 0 ]; then
    echo "sudo ./clog.sh"
    exit 1
fi

read -rp "Rock n Roll ? (Y/N): " choice

if [ "$choice" = "Y" ] || [ "$choice" = "y" ]; then

	echo "Starting log clearing process..."
	echo "--------------------------------"

	find "/var/log" -type f -name "*log*" | while read -r clog; do
	    if [ -f "$clog" ]; then
	        if [ -r "$clog" ]; then
	            echo "Clearing... $clog [done]"
	        else
	            echo "Error $clog Permission Denied"
	        fi
	    else
	        echo "Error $clog File not exists"
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
