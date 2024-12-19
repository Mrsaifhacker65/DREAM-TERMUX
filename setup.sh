#!/bin/bash
clear
# Backup existing bash.bashrc
output="/data/data/com.termux/files/usr/etc/"
if [ -f "${output}bash.bashrc" ]; then
    mv "${output}bash.bashrc" "${output}bash.bashrc.bak"
    echo -e "\033[1;32mExisting bash.bashrc backed up as bash.bashrc.bak\033[0m"
fi

# Update and upgrade packages
echo -e "\033[1;35mUpdating and upgrading packages...\033[0m"
apt-get update -y && apt-get upgrade -y

termux-setup-storage 

cp typing.mp3 /sdcard

# Ask the user if they want to visit the GitHub page
echo -e "\033[1;35mDo you want to visit my GitHub page? (y/n)\033[0m"
read -p "Enter your choice: " choice

# Check the user's input
if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
    echo -e "\033[1;35mRedirecting to GitHub...\033[0m"
    termux-open-url https://github.com/Mrsaifhacker65
else
    echo -e "\033[1;32mYou chose not to visit GitHub. Exiting...\033[0m"
fi
clear

# Function to display progress bar during a command execution
progress_bar() {
    local pid=$1  # Process ID of the running command
    local percent=0
    echo -ne "\033[1;35m$2\033[0m\n"  # Display message in purple

    # Loop until the process is running
    while kill -0 "$pid" 2>/dev/null; do
        echo -ne "["
        for ((i = 0; i < percent; i += 2)); do echo -n "="; done
        for ((i = percent; i < 100; i += 2)); do echo -n " "; done
        echo -n "] $percent%\r"
        sleep 0.1
        ((percent = (percent + 2) % 102))  # Loop percent back to 0 after 100
    done
    echo -ne "[==================================================] 100%\n"
}

# Function to install a package with progress bar
install_package() {
    echo -e "\033[1;36mInstalling $1...\033[0m"
    pkg install -y "$1" &>/dev/null &  # Run installation in the background
    progress_bar $! "Installing $1"    # Show progress bar while installation runs
    if [ $? -eq 0 ]; then
        echo -e "\033[1;32m$1 installed successfully!\033[0m"
    else
        echo -e "\033[1;31mError: Failed to install $1\033[0m"
        exit 1
    fi
}

# Function to install gem with progress bar
install_gem() {
    echo -e "\033[1;36mInstalling $1 gem...\033[0m"
    gem install "$1" &>/dev/null &  # Run gem installation in the background
    progress_bar $! "Installing $1 gem"  # Show progress bar while gem installs
    if [ $? -eq 0 ]; then
        echo -e "\033[1;32m$1 gem installed successfully!\033[0m"
    else
        echo -e "\033[1;31mError: Failed to install $1 gem\033[0m"
        exit 1
    fi
}

# Begin installation process
echo -e "\033[1;36mStarting the installation process...\033[0m"

# Install packages
install_package "mpv"
install_package "figlet"
install_package "python2"
install_package "ruby"

# Install lolcat gem
install_gem "lolcat"

# Finish
echo -e "\033[1;32mInstallation completed successfully!\033[0m"

# Set output path
output="/data/data/com.termux/files/usr/etc/"

# Ask for user input (name)
clear
echo -e "\n\n\n\n\t\033[1;35m Input Your Name 👉 : \c"
read name
echo
echo
echo

# Create the Python welcome script
cat <<EOF > "${output}wlc.py"
import os, sys, time, random
import subprocess  # To run the mpv command

# Play typing.mp3 silently in the background
subprocess.Popen(["mpv", "--no-terminal", "--loop=inf", "/sdcard/typing.mp3"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

# Typing welcome message
print("")
color = ["\\033[1;32m", "\\033[1;32m"]
m = random.choice(color) + " Welcome To TermuX ~ (◕‿◕)☞ '$name' \\n"
for msg in m:
    sys.stdout.write(msg)
    sys.stdout.flush()
    time.sleep(0.2)

# Stop the mpv sound after the message finishes
os.system("pkill mpv")
print("")
EOF

# Create bash.bashrc content
cat << 'EOF' > "${output}bash.bashrc"
clear
echo
echo "  < ━━━━━━━━━━━ [★] T E R M U X [★] ━━━━━━━━━━━━ >   " | lolcat
echo "  ┌─────────────────────────────────────────────┐" | lolcat
echo "  │     Developed By - Mr.Saif Hacker....⚔      │" | lolcat
echo "  └─────────────────────────────────────────────┘" | lolcat
echo "                ⣀⣤⣤⠶⠶⠚⠛⠛⠛⠛⠛⠛⠛⠷⠶⢦⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀ ⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⢀⣠⣴⠞⠛⠉⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⠉⠙⠻⢶⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
 ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡴⠟⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⢷⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀ ⠀⠀⠀⠀⠀⣠⡾⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⣦⡀⠀⠀⠀⠀⠀⠀
⠀⠀ ⠀⠀⠀⣠⡾⠋⠀⠀⠀⠀⣀⠄⠀⠀⠀⠀⠀⠀⢀⣠⣤⣤⡤⠤⠤⢤⣤⣀⡀⠀⠀⠀⠀⠀⠀⢄⡀⠀⠀⠀⠈⠻⣆⠀⠀⠀⠀⠀
⠀ ⠀⠀⢀⣴⠏⠀⢀⣀⣠⣶⠟⠁⠀⠀⠀⣠⠴⠀⢀⠔⠋⢁⠎⠀⡇⠘⡄⠉⠲⣍⠑⠢⢄⡀⠀⠀⠀⠙⣷⣦⣤⡀⠀⠙⣷⡀⠀⠀⠀
⠀ ⠀⢀⣾⠃⠀⣴⠏⣼⡿⣣⠀⠀⢀⡴⠋⠠⢄⡴⠃⠀⠀⡞⠀⠀⠃⠀⠹⡄⠀⠈⢳⡀⠤⠘⠢⡀⠀⠀⢾⢻⣷⡘⣦⡀⠈⢿⡄⠀⠀
 ⠀⠀⣾⠁⣠⢺⣿⢘⣭⣾⠃⠀⡰⠋⠀⠀⢀⡜⠁⠁⠀⢺⠀⣴⣞⡳⣶⡄⠁⠀⠉⠀⠱⡄⠀⠀⠈⠢⡀⠈⢷⣬⡓⢻⣷⢦⠈⢿⡄⠀
 ⠀⣼⠃⢰⡇⢸⣷⡿⢻⠁⢀⠞⠀⠀⠀⠀⡜⠀⠀⠀⠀⠈⠀⠈⠁⣷⠿⠃⠀⠀⠀⠀⠀⢱⡀⠀⠀⠀⠱⡄⠀⢿⢿⣾⡿⢸⣧⠈⣷⠀
 ⢠⡟⠀⣾⣿⢸⣫⣶⠇⠀⡞⠀⠀⠒⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡃⠀⠀⠀⠀⠀⠀⠀⠀⠃⠠⠀⠀⠀⢹⡀⠘⣷⣌⠧⢸⣿⠀⢸⡇
 ⣼⡇⣰⢻⣿⣸⡿⠋⠀⢸⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠻⠿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢧⠀⢸⣿⣧⣼⡿⢀⠀⣷
 ⣿⠀⣿⡀⢿⡟⢡⡇⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣶⣶⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡄⠸⣆⠻⣿⠃⣼⠀⢿
 ⣿⠀⢿⣷⠘⢰⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣶⡟⠀⣹⣯⡁⢸⣷⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡁⠀⢿⣦⠙⣼⣿⠀⢸
 ⣿⠀⠘⣿⣇⣿⡏⡄⠀⣄⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⠃⠀⢰⣇⠀⠀⣿⣿⣿⣿⣿⣷⡆⠀⠀⠀⠀⠀⢸⠁⢀⠸⣿⢰⣿⠇⠀⣾
 ⢻⡇⣷⡈⢻⣿⢀⣿⠀⢸⡀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⡇⠀⢸⣿⠀⢠⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⡾⠀⣼⡆⢿⡿⠃⣼⠀⣿
 ⠘⣧⠘⣿⣦⡙⢸⣿⣦⡀⢣⠀⡠⠤⠒⣿⣿⣿⣿⣿⣿⣿⣿⡄⢸⣿⢀⣾⣿⣿⣿⣿⣿⣿⣿⠒⠢⠤⣀⣰⠁⡰⣿⡇⢚⣴⣾⠏⢸⡇
 ⠀⢻⡄⢈⠻⣿⣼⣿⡇⣷⡈⢦⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠀⠀⡰⢃⣼⠁⣿⣧⣾⡿⡃⢀⡿⠀
 ⠀⠈⢿⡀⢷⣌⠛⢿⣧⢸⣷⡀⠑⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠜⠁⣼⡟⢸⡿⠟⣉⡴⠃⣼⠃⠀
 ⠀⠀⠈⢿⡄⠻⢿⣶⣬⣁⢿⣧⢳⣄⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣠⡖⣹⣿⢃⣥⣴⣾⠟⢁⣼⠃⠀⠀
⠀ ⠀⠀⠈⢻⣆⠀⢝⠻⠿⢿⣿⣦⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⣰⣿⡿⠿⠟⣋⠁⢠⡾⠃⠀⠀⠀
⠀⠀ ⠀⠀⠀⠙⢷⡀⠙⠶⣶⣤⣤⣥⣬⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣭⣼⣥⣤⣶⡶⠛⢁⣴⠟⠀⠀⠀⠀⠀
⠀⠀⠀⠀ ⠀⠀⠀⠻⢦⣀⠀⢭⣉⣙⣉⣉⣁⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣌⣉⣉⣋⣉⡩⠁⢀⣴⠟⠁⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠙⠷⣤⡈⠙⠛⠻⠛⠛⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠛⠛⠛⠛⠛⢉⣠⡶⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⠀⠈⠙⠷⣦⣄⣀⠀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⢀⣀⣤⠶⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⠀⠈⠉⠛⠻⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⠛⠋⠉      " |lolcat

echo "  < ━━━━━━━━━━━ [★]MR.SAIFHACKER[★] ━━━━━━━━━━━━ > " |lolcat
echo
python /data/data/com.termux/files/usr/etc/wlc.py
if [ -x /data/data/com.termux/files/usr/libexec/termux/command-not-found ]; then
    command_not_found_handle() {
        /data/data/com.termux/files/usr/libexec/termux/command-not-found "$1"
    }
fi
EOF
cat <<EOF >> "${output}bash.bashrc"
PS1="\033[1;32m┌─[\033[1;31m${name}@termux\033[1;32m]─[\033[1;35m\w\033[1;32m]\n\033[1;32m└─➤ \033[0m"
EOF

# Final Message
echo -e "\033[1;32mSetup completed! \033[0m"
echo
cat letter.txt
echo
echo
echo " EXIT FROM TERMUX AND RE OPEN IT AFTER 2 SECONDS " |lolcat
echo
echo
# Add final message about reverting
echo
echo -e "\033[1;32mTo restore TermuX to its original state, run: ./revert.sh\033[0m"
echo
ech
