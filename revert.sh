#!/bin/bash
clear
echo -e "\033[1;35mReverting to default TermuX settings...\033[0m"

# Define the etc folder path
output="/data/data/com.termux/files/usr/etc/"

# Remove files created by the tool
echo -e "\033[1;35mRemoving custom files...\033[0m"
rm -f "${output}wlc.py"
rm -f "${output}bash.bashrc"

# Restore original bash.bashrc if it exists
if [ -f "${output}bash.bashrc.bak" ]; then
    mv "${output}bash.bashrc.bak" "${output}bash.bashrc"
    echo -e "\033[1;32mOriginal bash.bashrc restored!\033[0m"
else
    echo -e "\033[1;31mNo backup of bash.bashrc found. Original file was not restored.\033[0m"
fi

# Kill any background processes started by the tool
echo -e "\033[1;35mStopping background processes...\033[0m"
pkill mpv 2>/dev/null

# Final message
echo -e "\033[1;32mRevert completed! TermuX is now back to its original state.\033[0m"