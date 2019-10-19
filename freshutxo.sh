#/bin/bash
source $HOME/node.conf
echo $NODEADDR
$HOME/komodo/src/komodo-cli sendtoaddress $NODEADDR 0.05
sleep 1
$HOME/komodo/src/komodo-cli sendtoaddress $NODEADDR 0.15
sleep 1
$HOME/komodo/src/komodo-cli sendtoaddress $NODEADDR 0.3
