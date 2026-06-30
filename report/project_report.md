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

For this milestone, I started by creating the two files `index.html` and `styles.css` in `files/web_files/` and pasted their contents from the project guide. I ran the following commands in the terminal to obtain the details I would include in the `index.html` file as proof of customization:
```
whoami # to get the name of the current user
hostname # to get the name of the current host (server) I'm on
date # to get the current date
cat /etc/lsb-release # to get details about the server's operating system
```

I then confirmed that Nginx was installed and started by running `nginx -v` and `sudo systemctl status nginx` respectively. Before making any changes, I ran `sudo nginx -t` to confirm the default configuration is okay and confirmed the default Nginx website was live on `http://localhost.`

I then created my own configuration file called `webapp` and stored it in `/etc/nginx/sites-available`:
```
        server {
                listen 80;
                server_name localhost;

                location / {
                        root /var/www/webapp;
                        index index.html;
                }
        }
```

I then created a folder `webapp` in the `/var/www/` directory and copied my project files there.

Next was to create a symbolic link of my configuration file in the `/etc/nginx/sites-enabled/` folder which I did by running
```
sudo ln -s /etc/nginx/sites-available/webapp /etc/nginx/sites-enabled/
``` 

I then ran `sudo nginx -t` to confirm the configuration was okay before reloading Nginx. I was able to confirm my website was successfully served on `http://localhost`.

### Areas for improvement
* Read the official Nginx documentation and practice more to gain a better understanding of Nginx

[Go to Milestone 3 screenshots](https://github.com/KarenNgugi/CNE01-Independent_Project_1/tree/main/screenshots/milestone_3)

## Milestone 4: Troubleshooting & Operations

### Issue 1: git push error
The first error I came across was 
```
error: src refspec main does not match any
error: failed to push some refs to 'github.com:KarenNgugi/CNE01-Independent_Project_1.git'
```
This happened right after I had initialized git locally and I had created the project repository on GitHub so I was trying to sync the two. It turned out that I needed to add and commit files first before I can push because I had created the `.gitignore` and `project notes.docx` files prior to creating the repository. So once I ran the following commands, I was sorted:
```
git add .
git commit -m "created .gitignore file"
git push -u origin main
```

### Issue 2: shell script not recognizing variables
When getting started on shell scripting, I decided to start with a very simple sample code that could test receiving and printing arguments. However, when I ran the script, I got the following error:
```
./create_user.sh: line 3: USER: command not found 
./create_user.sh: line 4: GROUP: command not found 
```

Upon inspection, I realized that I had surrounded the assignment operators ( `=` ) with spaces, which was fine for Python but not for shell scripting:
```
#!/bin/bash

USER = $1
GROUP = $2

echo "$USER"
echo "$GROUP"
```

Once I removed the spaces before and after the assignment operators, the error was resolved, and I was able to print the arguments to the terminal successfully.

### Issue 3: shell syntax error
Another error I encountered while still on shell scripting was, again, on wrong syntax:
```
./create_user.sh: line 10: syntax error: unexpected end of file from 'if' command on line 6
```

Initially, my code looked like this:
```
#!/bin/bash

USER=$1
GROUP=$2

if [ -z "$1" ] && [ -z "$2" ]
        read -p "Please enter a user and a group to add: " USER GROUP
        
echo "$USER"
echo "$GROUP"

```
I looked into it and discovered that, in shell scripting, there should be a semicolon immediately after the condition followed by the keyword `then`, and the whole code block needs to be closed off with the `fi` keyword. So I incorporated the conditions and the error was resolved.

### Issue 4: Nginx configuration test failed
While working on the third milestone for the project, I encountered an issue with Nginx. I had created my own configuration file in `/etc/nginx/sites-available/webapp`, then created the `/var/www/webapp` directory where I moved my static web files to. I had not fully understood how exactly Nginx works so when I created the symbolic link by running
```
sudo ln -s /var/www/webapp/ /etc/nginx/sites-enabled/
sudo nginx -t
```
The output was:
```
2026/06/29 13:32:24 [crit] 19857#19857: pread() "/etc/nginx/sites-enabled/webapp" failed (21: Is a directory)
nginx: configuration file /etc/nginx/nginx.conf test failed
```
I immediately understood that the issue was that I created a symbolic link to a directory, which was not acceptable. So, being in the `/etc/nginx/` directory, I deleted the existing symbolic link tried another way:
```
sudo ln -s sites-available/webapp sites-enabled/
sudo nginx -t
```
Again, the test failed with output:
```
2026/06/29 13:32:24 [emerg] 19857#19857: open() "/etc/nginx/sites-enabled/webapp" failed (2: No such file or directory) in /etc/nginx/nginx.conf:61
nginx: configuration file /etc/nginx/nginx.conf test failed
```

I inspected line 61 in `/etc/nginx/nginx.conf` and found the following: 
```
include /etc/nginx/sites-enabled/*;
```
On a hunch, I decided to include the full path rather than the relative paths even though I was in the `/etc/nginx/` directory, and the issue was resolved.

### Areas for improvement
* I should do more exploration and research so that I can deliberately cause errors to better understand the systems I'm working with

[Go to Milestone 4 screenshots](https://github.com/KarenNgugi/CNE01-Independent_Project_1/tree/main/screenshots/milestone_4)

## Lessons learned
* Setting up users and groups and managing access was a lot more challenging than I anticipated. I had to very critically think about who should belong to which group and the access they will or won't have.
* When updating user and group ownership of files and directories, it's best to leave that till the end because if you create any new files or directories, by default you get user and group ownership of those new files and directories.

