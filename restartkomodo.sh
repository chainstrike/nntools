#!/bin/bash
/home/$USER/komodo/src/komodo-cli stop &
#/home/$USER/komodo/src/fiat-cli stop &
sleep 60
#pkill -9 komodod &
#sleep 3
#pkill -9 komodod &
#sleep 3
#pkill -9 komodod &
#sleep 3
screen -r -S "komodo" -X stuff $'/home/$USER/komodo/src/komodod -gen -genproclimit=2 -notary -pubkey=\"023cb3e593fb85c5659688528e9a4f1c4c7f19206edc7e517d20f794ba686fd6d6\"\n'
#sleep 10
#screen -r -S "chains" -X stuff $'/home/$USER/komodo/src/assetchains\n'
