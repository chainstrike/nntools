#!/bin/bash

# Suggest using with this command: watch --color -n 60 ./status
#RED='\033[0;31m'
#GREEN='\033[0;32m'
#NC='\033[0m' # No Color
UTXO=0.0001

printf "====================\n"
printf "= BALANCES & UTXOS =\n"
printf "====================\n"

function process_check () {
  ps_out=`ps -ef | grep $1 | grep -v 'grep' | grep -v $0`
  result=$(echo $ps_out | grep "$1")
 if [[ "$result" != "" ]];then
    echo "here"
    return 1
  else
    echo "other"
    return 0
fi
}

processlist=(
'komodod'
'bitcoind'
'REVS'
'SUPERNET'
'DEX'
'PANGEA'
'JUMBLR'
'BET'
'CRYPTO'
'HODL'
'MSHARK'
'BOTS'
'MGW'
'COQUICASH'
'WLC'
'KV'
'CEAL'
'MESH'
'AXO'
'BTCH'
'ETOMIC'
'NINJA'
'OOT'
'BNTN'
'CHAIN'
'PRLPAY'
'DSEC'
'EQL'
'ZILLA'
'RFOX'
'HUSH3'
'SEC'
'CCL'
'PIRATE'
'PGT'
'KMDICE'
'DION'
'KSB'
'OUR'
'ILN'
'RICK'
'MORTY'
'KOIN'
'ZEXO'
'K64'
'THC'
'COMMOD'
)

count=0
while [ "x${processlist[count]}" != "x" ]
do
  echo -n "${processlist[count]}"
  size=${#processlist[count]}

  if [ "$size" -lt "8" ]
  then
    echo -n -e "\t\t"
  else
    echo -n -e "\t"
  fi

  if [ $(process_check $processlist[count]) ]
  then

    if [ "$count" = "0" ]
    then
            RESULT="$(/home/$USER/komodo/src/komodo-cli -rpcclienttimeout=15 listunspent | grep 0.00010000 | wc -l)"
            RESULT2="$(/home/$USER/komodo/src/komodo-cli -rpcclienttimeout=15 getbalance)"
    fi

    if [ "$count" = "1" ]
    then
            RESULT="$(/home/$USER/bitcoin/src/bitcoin-cli -rpcclienttimeout=15 listunspent | grep 0.00010000 | wc -l)"
            RESULT2="$(/home/$USER/bitcoin/src/bitcoin-cli -rpcclienttimeout=15 getbalance)"
    fi
    if [ "$count" -gt "1" ]
    then
            RESULT="$(/home/$USER/komodo/src/komodo-cli -rpcclienttimeout=15 -ac_name=${processlist[count]} listunspent | grep 0.00010000 | wc -l)"
            RESULT2="$(/home/$USER/komodo/src/komodo-cli -rpcclienttimeout=15 -ac_name=${processlist[count]} getbalance)"
    fi

  fi

  if [ "$RESULT" -gt "30" ]
  then
    printf  "U: $RESULT\t"
  else
    printf  "U: >>> $RESULT\t"
  fi

  if (( $(echo "$RESULT2 > 0.1" | bc -l) ));
  then
    printf  "B: $RESULT2\t\n"
  else
    printf  "B: >>> $RESULT2\t\n"
  fi

  RESULT=""
  RESULT2=""
  count=$(( $count +1 ))

done
