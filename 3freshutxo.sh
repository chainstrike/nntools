#/bin/bash
source $HOME/node.conf
echo $NODE_THIRD_ADDR
$HOME/komodo/src/komodo-cli sendtoaddress $NODE_THIRD_ADDR 0.011
sleep 1
$HOME/komodo/src/komodo-cli sendtoaddress $NODE_THIRD_ADDR 0.033
sleep 1
$HOME/komodo/src/komodo-cli sendtoaddress $NODE_THIRD_ADDR 0.777
