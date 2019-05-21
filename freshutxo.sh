#/bin/bash
source $HOME/node.conf
cd ~/komodo/src
./komodo-cli sendtoaddress $NODEADDR 0.11
sleep 3
./komodo-cli sendtoaddress $NODEADDR 0.51
sleep 3
./komodo-cli sendtoaddress $NODEADDR 1.11
