#!/usr/bin/env bash 
#wait for internet connection
for i in {1..50}; do ping -c1 www.google.com &> /dev/null && break; done

function ppgrep() { 
    pgrep "$@" | xargs ps fp 2> /dev/null; 
    }

#open apps
xdotool search --onlyvisible --classname --sync mailspring windowminimize

#xdotool search --onlyvisible --classname --sync protonvpn-gui windowminimize

xdotool search --onlyvisible --classname --sync Discord windowminimize
sleep 2
xdotool search --onlyvisible --classname --sync Discord windowminimize


exec mailspring & exit
sleep 1
xdotool getactivewindow windowminimize

sleep 5
sudo mount -a

notify-send -i terminal "Bootscript voltooid"

#pgrep proton -l | xargs -l bash -c 'echo $0 > getpid.txt; echo $1 > getname.txt;'

#cat getpid.txt
#cat getname.txt


#cat getpid.txt | xargs -l bash -c 'xdotool search --onlyvisible --pid $0 --sync --class proton;'
#xdotool search --onlyvisible --classname --sync mailspring windowminimize

