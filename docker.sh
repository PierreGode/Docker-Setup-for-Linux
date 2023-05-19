#!/bin/bash
##################################################################################################################################
#
#                                           This script is written by Pierre Gode
#      This program is open source; you can redistribute it and/or modify it under the terms of the GNU General Public
#                     This is a regular bash script and can be executed as: sh docker.sh
#
#
##################################################################################################################################
# ~~~~~~~~~~  Environment Setup ~~~~~~~~~~ #
NORMAL=$(tput sgr0)
MENU=$(tput setaf 4)  # Blue
NUMBER=$(tput setaf 3) # Yellow
RED_TEXT=$(tput setaf 1) # Red
INTRO_TEXT=$(tput setaf 2) # Green
# ~~~~~~~~~~  Environment Setup ~~~~~~~~~~ #

prompt_continue() {
    echo -n "${RED_TEXT}Continue? (y/N) ${NORMAL}"
    read -r answer
    if [ "$answer" != "${answer#[Yy]}" ] ;then
        return 0
    else
        return 1
    fi
}

install_docker() {
    echo "${RED_TEXT}This will install Docker on your machine.${NORMAL}"
    if prompt_continue; then
        apt-get remove docker docker-engine docker.io
        apt-get install -y apt-transport-https ca-certificates curl software-properties-common
        add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
        apt-get update
        apt-get install -y docker-ce
        echo "#################################"
        echo ""
        docker -v
        sleep 2
    fi
    show_menu
}

swarm_init() {
    echo "${RED_TEXT}This will initialize Swarm Manager on your machine.${NORMAL}"
    if prompt_continue; then
        myip=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')
        docker swarm init --advertise-addr $myip
        docker swarm join-token manager
        docker node ls
    fi
    show_menu
}

swarm_join() {
    echo "${RED_TEXT}This will setup Swarm worker on your machine.${NORMAL}"
    if prompt_continue; then
        echo "Paste worker Token"
        read -r worker_id
        docker swarm join --token $worker_id
    fi
    show_menu
}

show_menu() {
    clear
    echo "${INTRO_TEXT}Docker setup tool${NORMAL}"
    echo "${INTRO_TEXT}Created by Pierre Gode${NORMAL}"
    echo "${INTRO_TEXT}This script will edit several critical files.${NORMAL}"
    echo "${INTRO_TEXT}DO NOT attempt this without expert knowledge${NORMAL}"
    echo "${MENU}*${NUMBER} 1)${MENU} Install Docker CE${NORMAL}"
    echo "${MENU}*${NUMBER} 2)${MENU} Setup Swarm manager${NORMAL}"
    echo "${MENU}*${NUMBER} 3)${MENU} Setup Swarm worker${NORMAL}"
    echo "${NORMAL}Enter menu option or ${RED_TEXT}'x' to exit${NORMAL}"
    read -r opt
    case $opt in
        1) echo "Installing Docker CE"; install_docker ;;
        2) echo "Setting up Swarm Manager"; swarm_init ;;
        3) echo "Setting up Swarm worker"; swarm_join ;;
        x) echo "Exiting"; exit;;
        *) echo "Invalid option"; show_menu;;
    esac
}

show_menu
