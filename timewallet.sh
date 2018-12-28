#/bin/bash
echo "KMD:"
time komodo-cli listunspent > /dev/null
sleep 1
echo "BTC:"
time bitcoin-cli listunspent > /dev/null
