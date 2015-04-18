#!/bin/bash
############################
# orgmode-setup.sh
# This script clones the org-mode repo and gets a stable release
# You only need to run this script during setup. 
#
# Updating org-mode
# You can reuse the script to update the org-mode release
# Call 
#   git tag
# This will show the latest releases. Choose one and change 
# the release tag below
############################

# Clone org-mode into projects/org-mode
cd ~/projects
git clone git://orgmode.org/org-mode.git

# Select the current release
cd org-mode
git fetch --tags
git checkout release_8.2.7c

# Update and compile
git pull
make uncompiled

# Exit
cd ~
