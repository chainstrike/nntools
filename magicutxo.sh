#!/bin/bash
# change the FROM_ADDRESS and the address in the last line to where you want to send. issue the script which will generate output for createrawtransaction
# then, use komodo-cli and the output fully from above
# then, use komodo-cli signrawtransaction with the output from createrawtransaction call
# then, use komodo-cli sendrawtransaction with the signed hex
FROM_ADDRESS=RJEEZYoccpso3GT5BVZGn33tcWZzKsvwbV
curl -s https://kmdexplorer.io/insight-api-komodo/addr/$FROM_ADDRESS/utxo > all.utxos
utxos=$(<all.utxos)
utxo=$(echo "$utxos"   | jq -c "[.[] | select (.confirmations > 100 and .amount != 0.0001) | { txid: .txid, vout: .vout}]")
amount=$(echo "$utxos" | jq -r "[.[] | select (.confirmations > 100 and .amount != 0.0001) | .amount] | add")
# echo $amount
# https://stackoverflow.com/questions/46117049/how-i-can-round-digit-on-the-last-column-to-2-decimal-after-a-dot-using-jq
value=$(echo $amount | jq 'def round: tostring | (split(".") + ["0"])[:2] | [.[0], "\(.[1])"[:8]] | join(".") | tonumber; . | round')
# echo $value
echo "createrawtransaction '$utxo' '{\"RJEEZYoccpso3GT5BVZGn33tcWZzKsvwbV\": $value}'"
