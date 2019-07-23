#/bin/bash
source $HOME/node.conf
echo $NODE_THIRD_ADDR
$HOME/komodo/src/komodo-cli sendtoaddress $NODE_THIRD_ADDR 0.11
sleep 1
$HOME/komodo/src/komodo-cli sendtoaddress $NODE_THIRD_ADDR 0.51
sleep 1
$HOME/komodo/src/komodo-cli sendtoaddress $NODE_THIRD_ADDR 1.11
