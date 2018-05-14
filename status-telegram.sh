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
            RESULT="$(./komodo-cli -rpcclienttimeout=15 listunspent | grep 0.0001 | wc -l)"
            RESULT1="$(./komodo-cli -rpcclienttimeout=15  listunspent|grep amount|awk '{print $2}'|sed s/.$//|awk '$1 < 0.0001'|wc -l)"
            RESULT2="$(./komodo-cli -rpcclienttimeout=15 getbalance)"
    fi

    if [ "$count" = "1" ]
    then
            RESULT="$(bitcoin-cli -rpcclienttimeout=15 listunspent | grep 0.0001 | wc -l)"
            RESULT1="$(bitcoin-cli -rpcclienttimeout=15  listunspent|grep amount|awk '{print $2}'|sed s/.$//|awk '$1 < 0.0001'|wc -l)"
            RESULT2="$(bitcoin-cli -rpcclienttimeout=15 getbalance)"

    fi

    if [ "$count" = "2" ]
    then
            RESULT="$(chips-cli -rpcclienttimeout=15 listunspent | grep 0.0001 | wc -l)"
            RESULT1="$(chips-cli -rpcclienttimeout=15  listunspent|grep amount|awk '{print $2}'|sed s/.$//|awk '$1 < 0.0001'|wc -l)"
            RESULT2="$(chips-cli -rpcclienttimeout=15 getbalance)"

    fi

    if [ "$count" -gt "2" ]
    then
            cd ~/komodo/src
            RESULT="$(./komodo-cli -rpcclienttimeout=15 -ac_name=${processlist[count]} listunspent | grep 0.0001 | wc -l)"
            RESULT1="$(./komodo-cli -ac_name=${processlist[count]} -rpcclienttimeout=15  listunspent|grep amount|awk '{print $2}'|sed s/.$//|awk '$1 < 0.0001'|wc -l)"
            RESULT2="$(./komodo-cli -rpcclienttimeout=15 -ac_name=${processlist[count]} getbalance)"
    fi

  fi

  if [[ $RESULT == ?([-+])+([0-9])?(.*([0-9])) ]] ||
     [[ $RESULT == ?(?([-+])*([0-9])).+([0-9]) ]]
  then
	printf  "U: $RESULT\t"
  fi

  if [[ $RESULT2 == ?([-+])+([0-9])?(.*([0-9])) ]] ||
     [[ $RESULT2 == ?(?([-+])*([0-9])).+([0-9]) ]]
  then
	printf  "B: $RESULT2\t\n"
  fi

  RESULT=""
  RESULT2=""
  count=$(( $count +1 ))

done
