#!/bin/bash
GR='\033[0;32m'
NC='\033[0m' # No Color

printf "\n\n${GR}>>>>>>> CHECKING KOMODO${NC}\n"
cd /home/$USER/komodo/src
printf "${GR}>>>>>>> STASH${NC}\n"
git stash
printf "${GR}>>>>>>> CHECKOUT DEV${NC}\n"
git checkout dev
printf "${GR}>>>>>>> PULL${NC}\n"
git pull

printf "\n\n${GR}>>>>>>> CHECKING IGUANA${NC}\n"
cd /home/$USER/SuperNET/iguana
printf "${GR}>>>>>>> STASH${NC}\n"
git stash
printf "${GR}>>>>>>> CHECKOUT DEV${NC}\n"
git checkout dev
printf "${GR}>>>>>>> PULL${NC}\n"
git pull
printf "\n\n"
