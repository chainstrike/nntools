#/bin/bash
source $HOME/node.conf
echo $NODEADDR
$HOME/komodo/src/komodo-cli sendtoaddress $NODEADDR 0.1
sleep 1
$HOME/komodo/src/komodo-cli sendtoaddress $NODEADDR 0.3
sleep 1
$HOME/komodo/src/komodo-cli sendtoaddress $NODEADDR 0.7
