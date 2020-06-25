#!/usr/bin/env bash

#declaring variables
bold=$(tput bold)
normal=$(tput sgr0)
LIST="/home/todolist.txt"

printf "ToDoTerminal v0.1 - Running installer...\n\n"

#adding sleep so it's easier to see what's installing
sleep 2

#checking and installing dependencies
#also checking what Linux distro is running so it can launch the correct packet manager
#due to laziness I'm only supporting my two favourite distros which are Debian and Arch Linux (btw)
if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    OS=$NAME
    printf "Current distro: %s\n" "$OS"
    if  [[ $OS == "Arch Linux" ]]; then
        #check if package is installed or not
        pacman -Qi zsh $1 &> /dev/null
        if [[ $? -eq 0 ]]; then
        #package installed is true
            printf "\n\nYou already have this package installed.\n"
            read -r -p "Do you want to reinstall it? [Y/n] " input
            case $input in
                [yY][eE][sS]|[yY])
                sudo pacman -S zsh --overwrite="*"
                ;;
                    [nN][oO]|[nN])
            echo "No"
                 ;;
             *)
            echo "Invalid input..."
             exit 1
            ;;
            esac
        else 
            printf "\n\nAdditional packages will be installed."
            sudo pacman -S zsh	
            printf "\n\nDependencies installed;\n"
        fi

    elif [[ $OS == "Debian GNU/Linux" ]];then
        #check if package is installed or not
        sudo apt list --installed | grep zsh $1 &> /dev/null
        if [[ $? -eq 0 ]]; then
        #returns true
            printf "\n\nYou already have this package installed.\nDo you want to reinstall it?"
            read -r -p "Do you want to reinstall it? [Y/n] " input2
            case $input2 in
                [yY][eE][sS]|[yY])
                sudo apt-get install --reinstall zsh
                ;;
                    [nN][oO]|[nN])
            echo "No"
                 ;;
             *)
            echo "Invalid input..."
             exit 1
            ;;
            esac
        else 
            printf "\n\nAdditional packages will be installed."
            sudo apt-get install zsh
            printf "\n\nDependencies installed;\n"
        fi
    else
        printf "\n\nYour distro isn't natively supported.\n
        Please install ${bold}zsh${normal} through your favourite packet manager.\n\n"
    fi
else
    printf "\n\nYour distro isn't natively supported.\n
    Please install ${bold}zsh${normal} through your favourite packet manager.\n\n"
fi


sleep 3

#setting up alias for convenience
if grep -F "alias ttd='~/scripts/ToDoTerminal.sh'" ~/.bashrc
then
printf "Your alias has already been added.\n\n"
else
    echo "alias ttd='~/scripts/ToDoTerminal.sh'" >> ~/.bashrc
    printf "Alias has been added correctly\n\n"
fi
sleep 1

#reload bashrc
#doesn't actually reload and needs a fix still
#update: kinda works but unreliable
#update2: reliable enough, might fix later though
sleep 1
printf "Refreshing bash.rc\n\n"
source ~/.bashrc 

sleep 3

#creating ~/.todolist.txt
if [[ ! -f $LIST ]]; then
printf "%s doesn\'t exist.\nCreating file...\n" "$LIST"
sleep 1
touch /home/todolist.txt
echo " " >> $LIST
printf "File created.\n"
else
printf "$LIST already exists."
fi
sleep 1

printf "\n\nInstallation complete.\nYou can now use ToDoTerminal.\n\nAdd your first task by using ${bold}ttd add <task>\n"