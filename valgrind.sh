# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    valgrind.sh                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mtoia <mtoia@student.42roma.it>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/06 15:04:21 by mtoia             #+#    #+#              #
#    Updated: 2022/11/30 17:08:38 by mtoia            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

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

echo "${Purple}Now Installing Valgrind${End}"

brew tap LouisBrunner/valgrind


brew install --HEAD LouisBrunner/valgrind/valgrind

if test "$?" -ne 0
then
    echo "${Red}ERROR INSTALLING VALGRIND${End}"
    echo "${Red}Trying to resolve, maybe is Libtool${End}"
    brew update
    brew install Libtool
    brew install --HEAD LouisBrunner/valgrind/valgrind
    if test "$?" -ne 0
    then
        echo "${Red}ERROR INSTALLING VALGRIND${End}"
        echo "${Red}Veditela te, SUCA${End}"  
    else
        echo "${Green}Valgrind Installed${End}" 
    fi
else
    echo "${Green}Valgrind Installed${End}"
fi
