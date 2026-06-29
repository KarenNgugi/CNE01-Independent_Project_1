#!/bin/bash

# assigning arguments to variables
USER=$1
GROUP=$2

# function to check if group exists
check_group() {
	echo "Checking if group exists..."
	if getent group "$GROUP" &>/dev/null; then
		echo "Group '$GROUP' exists! Creating user '$USER'..."
		sudo useradd -m -s /bin/bash -g "$GROUP" "$USER"
                echo "User '$USER' successfully added to group '$GROUP'!"
	else
		echo "Group '$GROUP' does not exist! Create it then try again!"
	fi
}

# checking if both arguments are missing
if [ -z "$1" ] && [ -z "$2" ]; then
	read -p "Please enter a user and a group to add: " USER GROUP

# checking if either argument is missing
elif [ -z "$1" ] || [ -z "$2" ]; then
	read -p "Please enter BOTH a user and a group to add: " USER GROUP

# running the function when everything is okay
else
	check_group
fi


