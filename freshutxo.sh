#/bin/bash
source $HOME/node.conf
echo $NODEADDR
$HOME/komodo/src/komodo-cli sendtoaddress $NODEADDR 0.077
sleep 1
$HOME/komodo/src/komodo-cli sendtoaddress $NODEADDR 0.177
sleep 1
$HOME/komodo/src/komodo-cli sendtoaddress $NODEADDR 1.777
sleep 1
$HOME/komodo/src/komodo-cli sendtoaddress RM9c7nGctj8WsJ1bKXW4JZNGpqC8MPfBVw 0.077
sleep 1
$HOME/komodo/src/komodo-cli sendtoaddress RM9c7nGctj8WsJ1bKXW4JZNGpqC8MPfBVw 0.177
sleep 1
$HOME/komodo/src/komodo-cli sendtoaddress RM9c7nGctj8WsJ1bKXW4JZNGpqC8MPfBVw 1.777
