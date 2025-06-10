#!/bin/bash

# Prompt for commit message
read -p "Enter commit message: " msg

# Git workflow
git pull --rebase origin main || { echo "Rebase failed"; exit 1; }
git add .
git commit -m "$msg"
git push origin main
