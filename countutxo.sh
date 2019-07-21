#!/bin/bash
time (~/komodo/src/komodo-cli listunspent | jq '. | { "utxos" : length }' && ~/komodo/src/komodo-cli getwalletinfo | jq '{ "txcount" : .txcount }') | jq -s '.[0] * .[1]'
