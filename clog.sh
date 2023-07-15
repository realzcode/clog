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

	echo "\nStarting log clearing process..."
	echo "--------------------------------"

	find "/var/log" -type f -name "*log*" | while read -r clog; do
	    rm -rf $clog
	    echo "Clearing... $clog [done]"
	done

	cat /dev/null > /var/log/utmp 
	echo "Clearing... /var/log/utmp [done]"

	cat /dev/null > /var/log/wtmp
	echo "Clearing... /var/log/wtmp [done]"

	cat /dev/null > /var/log/btmp
	echo "Clearing... /var/log/btmp [done]"

	rm -rf /var/log/journal/*
	echo "Clearing... journalctl [done]"

	echo "-------------------------------"
	echo "Log clearing process completed."

	echo "\n* Some commands are done manually *"
	echo "Clear History Command: history -c"

else
    echo "Bye :p"
fi
