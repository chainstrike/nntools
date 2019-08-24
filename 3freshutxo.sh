#/bin/bash
source $HOME/node.conf
echo $NODE_THIRD_ADDR
$HOME/komodo/src/komodo-cli sendtoaddress $NODE_THIRD_ADDR 0.777
#sleep 1
#$HOME/komodo/src/komodo-cli sendtoaddress $NODE_THIRD_ADDR 0.30
#sleep 1
#$HOME/komodo/src/komodo-cli sendtoaddress $NODE_THIRD_ADDR 1.11
