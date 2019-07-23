#/bin/bash
source $HOME/node.conf
echo $NODEADDR
$HOME/komodo/src/komodo-cli sendtoaddress $NODEADDR 0.11
sleep 1
$HOME/komodo/src/komodo-cli sendtoaddress $NODEADDR 0.51
sleep 1
$HOME/komodo/src/komodo-cli sendtoaddress $NODEADDR 1.11
