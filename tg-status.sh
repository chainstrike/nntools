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
'chipsd'
'gamecreditsd'
'HUSH'
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
'COQUI'
'WLC'
'KV'
'CEAL'
'MESH'
'MNZ'
'AXO'
'BTCH'
'ETOMIC'
'NINJA'
'OOT'
'BNTN'
'CHAIN'
'PRLPAY'
'DSEC'
'GLXT'
'EQL'
'ZILLA'
'RFOX'
'VRSC'
'SEC'
'CCL'
'PIRATE'
'MGNX'
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
            cd ~/komodo/src
            RESULT="$(./komodo-cli -rpcclienttimeout=15 listunspent | grep 0.00010000 | wc -l)"
            RESULT2="$(./komodo-cli -rpcclienttimeout=15 getbalance)"
    fi

    if [ "$count" = "1" ]
    then
            RESULT="$(bitcoin-cli -rpcclienttimeout=15 listunspent | grep 0.00010000 | wc -l)"
            RESULT2="$(bitcoin-cli -rpcclienttimeout=15 getbalance)"
    fi

    if [ "$count" = "2" ]
    then
            RESULT="$(chips-cli -rpcclienttimeout=15 listunspent | grep 0.00010000 | wc -l)"
            RESULT2="$(chips-cli -rpcclienttimeout=15 getbalance)"
    fi

    if [ "$count" = "3" ]
    then
            RESULT="$(gamecredits-cli -rpcclienttimeout=15 listunspent | grep 0.00100000 | wc -l)"
            RESULT2="$(gamecredits-cli -rpcclienttimeout=15 getbalance)"
    fi

    if [ "$count" = "4" ]
    then
            RESULT="$(/home/$USER/hush/src/hush-cli -rpcclienttimeout=15 listunspent | grep .00010000 | wc -l)"
            RESULT2="$(/home/$USER/hush/src/hush-cli -rpcclienttimeout=15 getbalance)"

    fi

    if [ "$count" -gt "4" ]
    then
            cd ~/komodo/src
            RESULT="$(./komodo-cli -rpcclienttimeout=15 -ac_name=${processlist[count]} listunspent | grep 0.00010000 | wc -l)"
            RESULT2="$(./komodo-cli -rpcclienttimeout=15 -ac_name=${processlist[count]} getbalance)"
    fi

  fi

  if [ "$RESULT" -gt "50" ]
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
