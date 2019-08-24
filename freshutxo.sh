#/bin/bash
source $HOME/node.conf
echo $NODEADDR
$HOME/komodo/src/komodo-cli sendtoaddress $NODEADDR 0.777
#sleep 1
#$HOME/komodo/src/komodo-cli sendtoaddress $NODEADDR 0.30
#sleep 1
#$HOME/komodo/src/komodo-cli sendtoaddress $NODEADDR 1.11
