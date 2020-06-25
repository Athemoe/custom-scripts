#!/usr/bin/env bash

#declaring variables
bold=$(tput bold)
normal=$(tput sgr0)
LIST="/home/todolist.txt"

printf "TerminalToDo v0.1"

if [[ $1 == "add" ]]; then
    printf "What task would you like to add?\n"
    read -r varinputadd					
    #flushing echo output
    echo "$varinputadd" >> "$LIST" 2> /dev/null
    
    if grep -F "$varinputadd" $LIST
    then
        printf "%s has been added to the list.\n\n" "$varinputadd"
        printf "%sTo do list:\n" "${bold}"
        cat -n $LIST
        printf "\n\n"
    else

        printf "Error: couldn't write data to %s\nAre you root?\n" "$LIST"
    fi
elif [[ $1 == "check" ]]; then
    if [[ -s $LIST ]]; then
        cat -n $LIST
        printf "Enter the number of the task you want to delete: \n"
        read -r varinputcheck
        sed -i "${varinputcheck}d" $LIST 
        printf "\n\nTo-do List:\n"
        cat -n $LIST
        printf "\n"
    else
        printf "Your to-do list is already empty!"
    fi

elif [[ $1 == "help" ]]; then
    printf "ttd add - add a new item to the list
    \nttd check - mark an item as completed
    \nttd list - show your to-do list
    \nttd clear - clear your entire list\n"

elif [[ $1 == "clear" ]]; then

    read -r -p "Do you want to empty your list? [Y/n] " input4
    case $input4 in
        [yY][eE][sS]|[yY])
        sed -i '/^/d' $LIST
        if [[ -s $LIST ]]; then
            printf "Error: Couldn't clear %s" "$LIST"
        else
            printf "Cleared all objects."
        fi
        ;;
            [nN][oO]|[nN])
    echo "No"
            ;;
        *)
    echo "Invalid input..."
        exit 1
    ;;
    esac

elif [[ $1 == "list" ]]; then
    printf "${bold}To-do List:${normal}\n"
    cat -n $LIST
    printf "\n"
else
    printf "Use ${bold}ttd help${normal} to see all the available commands\n"      
fi