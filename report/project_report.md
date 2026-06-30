# Project Report
## Overview
This project granted me the opportunity to apply what I have learned so far about Linux system administration and NGINX web deployment.

## Milestone 1: Linux System Setup & Administration Basics
### File Structure
I started by creating a new repository, both locally and on GitHub, to enable version control and portability of project files. I created a **.gitignore** file to add files and directories I did not want to track.

I then created the following project structure:
```
├── files/
│   ├── configurations/
│   ├── scripts/
│   └── web_files/
├── project_summary.md
├── report/
└── screenshots/
    ├── milestone_1/
    ├── milestone_2/
    ├── milestone_3/
    └── milestone_4/

```
I chose this structure because it is organized and stores the relevant files where they should be.
* **`files/`** : this directory contains the directories for configuration files, shell scripting files, and web server files.
* **`project_summary.md`** : this file provides a summary of what the project is about as well as the files and directories contained in the project directory.
* **`report/** : this directory contains this report in Markdown.
* **`screenshots/`** : this file provides the screenshots of each of the four milestones that constitute this independent project.


### Users, Groups, and Permissions
I imagined that I was working for a small company and decided to create the following groups to reflect the various employees working there:
* **`company`** : this group will contain all the employees at the company
* **`ict_team`** : this group will contain all ICT employees
* **`ict_admin`** : this group will contain only people with ICT admin role
* **`ict_dev`** : this group will contain people who are developers and also those with ICT admin role
* **`ict_test`** : this group will contain people who are testers and also those with ICT admin role
* **`staff`** : this group will contain company non-ICT staff who may need to access the ICT team's files such as HR managers, audit officers, etc.

Since the project is an ICT project, it makes sense that group ownership of all project files and directories should be transferred to **`ict_team`**.

I then created new users for the following groups:
* **`ict_admin`** : 1 user ( `admin1` )
* **`ict_dev`** : 2 users ( `dev1` and `dev2` )
* **`ict_test`** : 1 user ( `tester1` )
* **`staff`** : 3 users ( `staff1`, `staff2`, `staff3` )

All the users were added to **`company`**, and all ICT staff were added to **`ict_team`**.

Finally, I decided that the **`project_summary.md`** file should be group-owned by **`company`** so that anyone in the group can read it, but only the user ( **`admin1`** ) has read and write permissions. For the rest of the project directories ( **`files/`**, **`report/`**, **`screenshots/`** ), the user owner is **`admin1`** while the group owner is **`ict_team`**. Both the user and the group have full permissions while the others have only read and execute permissions.

### Areas for improvement
* Create users with more meaningful names, e.g., "john_doe", "alice-smith"
* 

[Go to Milestone 1 screenshots](https://github.com/KarenNgugi/CNE01-Independent_Project_1/tree/main/screenshots/milestone_1)

## Milestone 2: Shell Scripting & Automation
### The Script 
In the `files/scripts/` directory, I created the `create_user.sh` file and gave it executable permissions. Below is the content of the file:
```
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
```

### Script description
The script first stores the first and second arguments provided in the terminal in variables `USER` and `GROUP`, respectively. This assumes that the first argument provided will be the name of a new user to create and the second argument will be the name of an existing group to add the user to.

Then there is a function to check if the group exists. It will first print out "Checking if group exists..." to the console before carrying out a conditional test to check whether the group exists. If it does, the script outputs "Group '<group_name>' exists! Creating user '<user_name>'..." before proceeding to create the user with their own home directory and the `/bin/bash` shell while adding them to the specified group. When this is completed, the script outputs "User '<user_name>' successfully added to group '<group_name>'!". However, if the group does not exist, the script prints "Group '<group_name>' does not exist! Create it then try again!" to the console then stops.

However, the function is not called until after confirming that both arguments are present. If no arguments have been provided, the script displays the message "Please enter a user and a group to add: " while prompting the user to input the arguments. If only one argument has been provided, the script prints "Please enter BOTH a user and a group to add: ". Otherwise, the script proceeds with calling the function.


### Areas for improvement
* Make the shell script file more strict about the exact arguments it receives (e.g., there must be EXACTLY two arguments provided)
* Revise the shell script file to automatically assign new users to groups based on roles (e.g. `./create_user alice developer` should create a new user called `alice` and automatically assign them to the `ict_dev` group. All company employees should automatically be added to the `company` group.

[Go to Milestone 2 screenshots](https://github.com/KarenNgugi/CNE01-Independent_Project_1/tree/main/screenshots/milestone_2)

## Milestone 3: NGINX Static Website Deployment

### Areas for improvement

[Go to Milestone 3 screenshots](https://github.com/KarenNgugi/CNE01-Independent_Project_1/tree/main/screenshots/milestone_3)

## Milestone 4: Troubleshooting & Operations

### Areas for improvement

[Go to Milestone 4 screenshots](https://github.com/KarenNgugi/CNE01-Independent_Project_1/tree/main/screenshots/milestone_4)

## Lessons learned
* Setting up users and groups and managing access was a lot more challenging than I anticipated. I had to very critically think about who should belong to which group and the access they will or won't have.
* When updating user and group ownership of files and directories, it's best to leave that till the end because if you create any new files or directories, by default you get user and group ownership of those new files and directories.

