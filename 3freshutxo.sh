#/bin/bash
source $HOME/node.conf
cd ~/komodo/src
echo $NODE_THIRD_ADDR
sleep 3
./komodo-cli sendtoaddress $NODE_THIRD_ADDR 0.11
sleep 3
./komodo-cli sendtoaddress $NODE_THIRD_ADDR 0.51
sleep 3
./komodo-cli sendtoaddress $NODE_THIRD_ADDR 1.11
