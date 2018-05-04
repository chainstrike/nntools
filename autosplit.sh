#!/bin/bash

# Minimum number of UTXOs to maintain
MINUTXOS=150
# Amount of UTXOs to create at one time
SPLITAMNT=50

# Load coinlist from file
source /home/$USER/nntools/coinlist.split



# Manual Check of BTC, CHIPS, KMD
echo "Checking BTC, CHIPS, KMD"
cd ~
echo -n BTC
UTXOS="$(/usr/bin/bitcoin-cli listunspent | grep .0001 | wc -l)"
echo -n -e '\t\t';echo -n "$UTXOS"
if [ "$UTXOS" -lt "$MINUTXOS" ]
   then
     echo -n " - SPLITFUNDING BTC"
     RESULT="$(/home/$USER/nntools/acsplit.sh BTC $SPLITAMNT)"
     echo $RESULT
   fi
echo ""
cd ~/chips3/src
echo -n CHIPS
UTXOS="$(/usr/local/bin/chips-cli listunspent | grep .0001 | wc -l)"
echo -n -e '\t\t';echo -n "$UTXOS"
if [ "$UTXOS" -lt "$MINUTXOS" ]
   then
     echo -n "SPLITFUNDING CHIPS"
     RESULT="$(/home/$USER/nntools/acsplit.sh CHIPS $SPLITAMNT)"
     echo $RESULT
   fi
echo ""
cd ~/komodo/src
echo -n KMD
UTXOS="$(/usr/local/bin/komodo-cli listunspent | grep .0001 | wc -l)"
echo -n -e '\t\t';echo -n "$UTXOS"
if [ "$UTXOS" -lt "$MINUTXOS" ]
   then
     echo -n " - SPLITFUNDING KMD"
     RESULT="$(/home/$USER/nntools/acsplit.sh KMD 100)"
     echo $RESULT
   fi
echo ""
echo "Checking Other Coins"

# Check the rest of the coins using a loop
# Feel free to add coins as required here

count=0
while [ "x${coinlist[count]}" != "x" ]
do
  echo -n "${coinlist[count]}"
  UTXOS="$(/usr/local/bin/komodo-cli -ac_name=${coinlist[count]} listunspent | grep .0001 | wc -l)"
  echo -n -e '\t\t';echo -n "$UTXOS"
  if [ "$UTXOS" -lt "$MINUTXOS" ]
     then
       echo -n " - SPLIT FUNDING: ${coinlist[count]}"
       RESULT="$(/home/$USER/nntools/acsplit.sh ${coinlist[count]} $SPLITAMNT)"
       echo $RESULT
     fi
  count=$(( $count +1 ))
  echo ""
done
echo "FINISHED"
