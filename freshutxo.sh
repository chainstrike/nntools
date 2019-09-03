#/bin/bash
source $HOME/node.conf
echo $NODEADDR
$HOME/komodo/src/komodo-cli sendtoaddress $NODEADDR 0.011
sleep 1
$HOME/komodo/src/komodo-cli sendtoaddress $NODEADDR 0.033
sleep 1
$HOME/komodo/src/komodo-cli sendtoaddress $NODEADDR 0.777
