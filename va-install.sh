# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    va-install.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mtoia <mtoia@student.42roma.it>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/05 18:49:01 by mtoia             #+#    #+#              #
#    Updated: 2022/11/30 17:11:18 by mtoia            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/usr/bin/env bash

dir=$(dirname -- "$0")
current_dir=$(pwd)

Black='\033[0;30m'
DarkGray='\033[1;30m'
Red='\033[0;31m'
LightRed='\033[1;31m'
Green='\033[0;32m'
LightGreen='\033[1;32m'
BrownOrange='\033[0;33m'
Yellow='\033[1;33m'
Blue='\033[0;34m'
LightBlue='\033[1;34m'
Purple='\033[0;35m'
LightPurple='\033[1;35m'
Cyan='\033[0;36m'
LightCyan='\033[1;36m'
LightGray='\033[0;37m'
White='\033[1;37m'
End='\033[0m'

trap "exit" INT

echo "${Purple}Installer script for Brew & Valgrind *42\n${End}"
echo "${Blue}"
base64 -D <<<"H4sIALZ+h2MAA12MwQ0AIAgD/0xBwrMbdP/BJBUMckZpuUR3QfIFYVXBL9SQBaHbvJwWgbG4tbAsfZbqnz3dGMtGxH2FHRfoG6bCAAAA" | gunzip
echo "${Purple}Checking if Brew is already installed${End}"

if ! command -v brew &> /dev/null
then
    echo "${LightBlue}Installing Brew${End}"
    curl -fsSL https://rawgit.com/kube/42homebrew/master/install.sh | zsh
fi

if test "$?" -ne 0
then
    echo "${Red}ERROR INSTALLING BREW $res"
else
    echo "${Green}Brew Installed"
fi

echo "${Purple}Installing Valgrind${End}"

nodir="."

if [ "$dir" = "$nodir" ]
then
    va_path="sh ${current_dir}/valgrind.sh"
else
    va_path="sh ${dir}/valgrind.sh"
fi

if ! command -v brew &> /dev/null
then
  echo "${Purple}Opening a new Terminal for install valgrind${End}"
      osascript &>/dev/null <<EOF
        tell application "iTerm2"
         		create window with default profile 
         		tell current session of current window
         			delay 1
         			write text "$va_path"
         		end tell
        end tell
EOF
    exit
fi

brew tap LouisBrunner/valgrind

brew install --HEAD LouisBrunner/valgrind/valgrind

if test "$?" -ne 0
then
    echo "${Red}ERROR INSTALLING VALGRIND"
    echo "${Red}Trying to resolve, maybe is Libtool"
    brew update
    brew install Libtool
    brew install --HEAD LouisBrunner/valgrind/valgrind
    if test "$?" -ne 0
    then
        echo "${Red}ERROR INSTALLING VALGRIND"
        echo "${Red}Check if are no space left on device \nCheck the log output\n${End}"  
    else
        echo "${Green}Valgrind Installed" 
    fi
else
    echo "${Green}Valgrind Installed"
fi
