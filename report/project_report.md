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
* For the project directories, grant others read-only permission to follow the principle of least privilege

Go to Milestone 1 screenshots

## Milestone 2: Shell Scripting & Automation
Go to Milestone 2 screenshots

## Milestone 3: NGINX Static Website Deployment
Go to Milestone 3 screenshots

## Milestone 4: Troubleshooting & Operations
Go to Milestone 4 screenshots

## Lessons learned
* Setting up users and groups and managing access was a lot more challenging than I anticipated. I had to very critically think about who should belong to which group and the access they will or won't have.
* When updating user and group ownership of files and directories, it's best to leave that till the end because if you create any new files or directories, by default you get user and group ownership of those new files and directories.

## Areas for improvement
* Create users with more meaningful names, e.g., "john_doe", "alice-smith"
* For the project directories, grant others read-only permission to follow the principle of least access
* Make the shell script file more strict about the exact arguments it receives (e.g., there must be EXACTLY two arguments provided)
* Revise the shell script file to automatically assign new users to groups based on roles (e.g. `./create_user alice developer` should create a new user called `alice` and automatically assign them to the `ict_dev` group