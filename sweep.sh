#!/bin/bash
cd "${BASH_SOURCE%/*}" || exit

coin="KMD"
address="RJEEZYoccpso3GT5BVZGn33tcWZzKsvwbV"
cli="komodo-cli"
txfee="0.0002"
date=$(date +%Y-%m-%d:%H:%M:%S)
iguana_age_threshold="999999"

echo "[${coin}] Checking mining UTXOs - ${date}"

mining_rewards=$(${cli} listunspent | jq -r 'map(select(.spendable == true and .amount > 3))')
no_of_mining_utxos=$(echo $mining_rewards | jq -r 'length')
total_mining_rewards=$(echo $mining_rewards | jq -r '.[].amount' | paste -sd+ - | bc)

echo "[${coin}] ${no_of_mining_utxos} mining UTXOs totalling ${total_mining_rewards} ${coin}"

no_of_utxos=$no_of_mining_utxos
amount_of_utxos=$total_mining_rewards

if [[ $no_of_utxos -gt 0 ]]; then
  output_amount=$(echo "$amount_of_utxos-$txfee" | bc)

  # Add a 0 if output amount starts with a decimal place
  if [[ "${output_amount:0:1}" = "." ]]; then
    output_amount="0${output_amount}"
  fi

  transaction_inputs=$(jq -r --argjson mining_rewards "$mining_rewards" -n '$mining_rewards | [.[] | {txid, vout}]')
  transaction_outputs="{\"$address\":$output_amount}"

  echo "[${coin}] Consolidating down ${output_amount} ${coin} to ${address}"

  raw_tx=$(${cli} createrawtransaction "$transaction_inputs" "$transaction_outputs")

  echo $raw_tx

  signed_raw_tx=$(${cli} signrawtransaction "${raw_tx}" | jq -r '.hex')
  #txid=$(${cli} sendrawtransaction "$signed_raw_tx")

  echo "${cli} sendrawtransaction $signed_raw_tx"

#  echo "[${coin}] TXID: ${txid}"
fi
