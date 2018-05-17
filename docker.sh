#!/bin/bash
##################################################################################################################################
#                                                                                                                                #
#                                           This script is written by Pierre Gode                                               #
#      This program is open source; you can redistribute it and/or modify it under the terms of the GNU General Public           #
#                     This is an normal bash script and can be executed with sh EX: ( sudo sh docker.sh )                        #
#                                                                                                                                #
#                                                                                                                                #
##################################################################################################################################
# ~~~~~~~~~~  Environment Setup ~~~~~~~~~~ #
    NORMAL=$(echo "\033[m")
    MENU=$(echo "\033[36m") #Blue
    NUMBER=$(echo "\033[33m") #yellow
    RED_TEXT=$(echo "\033[31m") #Red
    INTRO_TEXT=$(echo "\033[32m") #green and white text
    END=$(echo "\033[0m")
# ~~~~~~~~~~  Environment Setup ~~~~~~~~~~ #
install_me(){
sudo apt-get remove docker docker-engine docker.io
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce
echo "#################################"
echo ""
docker -v
sleep 2
MENU_FN
}
######################### manager #############################
swarm_me(){
Manager_FN(){
myip=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')
docker swarm init --advertise-addr $myip
sudo docker swarm join-token manager
sudo docker node ls
exit;
}
########################## worker ################################
Worker_fn(){
echo "Paste worker Token"
read worker_id
sudo docker swarm join --token $worker_id
exit;
}
############################## Swarm menu ##########################################################
clear
    echo "${MENU}*${NUMBER} 1)${MENU} Setup Swarm manager               ${NORMAL}"
    echo "${MENU}*${NUMBER} 2)${MENU} Setup Swarm worker               ${NORMAL}"
    echo "${NORMAL}                                                    ${NORMAL}"
    echo "${ENTER_LINE}Please enter a menu option and enter or ${RED_TEXT}enter to exit. ${NORMAL}"
	read opt
while [ opt != '' ]
    do
    if [ $opt = "" ]; then 
            exit;
    else
        case $opt in
    1) clear;
            echo "Setting up Swarm Manager";
            Manager_FN;
            ;;
	2) clear;
            echo "Setting up Swarm worker";
            Worker_fn;
            ;;
        x)exit;
        ;;
       \n)exit;
        ;;
        *)clear;
        opt "Pick an option from the menu";
        show_etcmenu;
        ;;
    esac
fi
done
}

MENU_FN(){
########################################### Menu #######################################

clear
    echo "${INTRO_TEXT}          Docker setup tool                     ${INTRO_TEXT}"
    echo "${INTRO_TEXT}       Created by Pierre Goude                  ${INTRO_TEXT}"
	echo "${INTRO_TEXT} This script will edit several critical files.. ${INTRO_TEXT}"
	echo "${INTRO_TEXT}  DO NOT attempt this without expert knowledge  ${INTRO_TEXT}"
    echo "${NORMAL}                                                    ${NORMAL}"
    echo "${MENU}*${NUMBER} 1)${MENU} Install Docker CE                      ${NORMAL}"
    echo "${MENU}*${NUMBER} 2)${MENU} Create swarm manager or worker    ${NORMAL}"
    echo "${NORMAL}                                                    ${NORMAL}"
    echo "${ENTER_LINE}Please enter a menu option and enter or ${RED_TEXT}enter to exit. ${NORMAL}"
	read opt
while [ opt != '' ]
    do
    if [ $opt = "" ]; then 
            exit;
    else
        case $opt in
    1) clear;
            echo "Installing Docker CE";
            install_me;
            ;;
	2) clear;
            echo "Setup swarm";
            swarm_me;
            ;;
        x)exit;
        ;;
       \n)exit;
        ;;
        *)clear;
        opt "Pick an option from the menu";
        show_etcmenu;
        ;;
    esac
fi
done
}
MENU_FN
