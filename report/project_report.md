# Project Report
## Overview

## Milestone 1: Linux System Setup & Administration Basics
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
* Make the shell script file more strict about the exact arguments it receives (e.g., there must be EXACTLY two arguments provided)
* Revise the shell script file to automatically assign new users to groups based on roles (e.g. `./create_user alice developer` should create a new user called `alice` and automatically assign them to the `ict_dev` group