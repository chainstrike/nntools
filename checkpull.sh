#!/bin/bash
GR='\033[0;32m'
NC='\033[0m'

printf "\n${GR}>>> CHECKING KOMODO${NC}\n"
cd /home/$USER/komodo/src
git stash
git checkout beta
git pull

printf "\n${GR}>>>>>>> CHECKING IGUANA${NC}\n"
cd /home/$USER/SuperNET/iguana
git stash
git checkout blackjok3r
git pull

#printf "\n${GR}>>>>>>> CHECKING HUSH${NC}\n"
#cd /home/$USER/hush3
#git stash
#git checkout dev
#git pull

#printf "\n${GR}>>>>>>> CHECKING CHIPS${NC}\n"
#cd /home/$USER/chips3
#git stash
#git checkout dev
#git pull

#printf "\n${GR}>>>>>>> CHECKING GAME${NC}\n"
#cd /home/$USER/GameCredits
#git stash
#git checkout master
#git pull

#printf "\n${GR}>>>>>>> CHECKING VERUS${NC}\n"
#cd /home/$USER/VerusCoin
#git stash
#git checkout master
#git pull

#printf "\n${GR}>>>>>>> CHECKING EMC2${NC}\n"
#cd /home/$USER/einsteinium
#git stash
#git checkout master
#git pull

printf "\n${GR}>>>>>>> CHECKING NANOMSG${NC}\n"
cd /home/$USER/nanomsg
git stash
git checkout master
git pull

printf "\n"
