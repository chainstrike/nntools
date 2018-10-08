#!/bin/bash

# Minimum number of UTXOs to maintain
MINUTXOS=100
# Amount of UTXOs to create at one time
SPLITAMNT=100
# Size of UTXOs
UTXOSIZE=0.00010000

# Load coinlist from file
source /home/$USER/nntools/coinlist.split



# Manual Check of BTC, CHIPS, KMD
echo "Checking BTC, CHIPS, KMD"

####### BTC
cd ~
echo -n BTC
UTXOS="$(/usr/bin/bitcoin-cli listunspent | grep $UTXOSIZE | wc -l)"
echo -n -e '\t\t';echo -n "$UTXOS"
if [ "$UTXOS" -lt "$MINUTXOS" ]
   then
     echo -n " - SPLITFUNDING BTC"
     RESULT="$(/home/$USER/nntools/acsplit.sh BTC $SPLITAMNT)"
     echo $RESULT
   fi
echo ""

####### CHIPS
cd ~/chips3/src
echo -n CHIPS
UTXOS="$(/usr/local/bin/chips-cli listunspent | grep $UTXOSIZE | wc -l)"
echo -n -e '\t\t';echo -n "$UTXOS"
if [ "$UTXOS" -lt "$MINUTXOS" ]
   then
     echo -n "SPLITFUNDING CHIPS"
     RESULT="$(/home/$USER/nntools/acsplit.sh CHIPS $SPLITAMNT)"
     echo $RESULT
   fi
echo ""

####### GAME
cd ~/GameCredits/src
echo -n GAMECREDITS
UTXOS="$(/usr/local/bin/gamecredits-cli listunspent | grep 0.00100000 | wc -l)"
echo -n -e '\t\t';echo -n "$UTXOS"
if [ "$UTXOS" -lt "50" ]
   then
     echo -n "SPLITFUNDING GAME"
     RESULT="$(/home/$USER/nntools/acsplitgame.sh GAME 30)"
     echo $RESULT
   fi
echo ""

####### KMD
cd ~/komodo/src
echo -n KMD
UTXOS="$(/usr/local/bin/komodo-cli listunspent | grep $UTXOSIZE | wc -l)"
echo -n -e '\t\t';echo -n "$UTXOS"
if [ "$UTXOS" -lt "$MINUTXOS" ]
   then
     echo -n " - SPLITFUNDING KMD"
     RESULT="$(/home/$USER/nntools/acsplit.sh KMD $SPLITAMNT)"
     echo $RESULT
   fi
echo ""

####### HUSH
cd ~/komodo/src
echo -n HUSH
UTXOS="$(/home/$USER/hush/src/hush-cli listunspent | grep $UTXOSIZE | wc -l)"
echo -n -e '\t\t';echo -n "$UTXOS"
if [ "$UTXOS" -lt "$MINUTXOS" ]
   then
     echo -n " - SPLITFUNDING HUSH"
     RESULT="$(/home/$USER/nntools/acsplit.sh HUSH $SPLITAMNT)"
     echo $RESULT
   fi
echo ""

####### EMC2
cd ~/einsteinium/src
echo -n EMC2
UTXOS="$(/home/$USER/einsteinium/src/einsteinium-cli listunspent | grep $UTXOSIZE | wc -l)"
echo -n -e '\t\t';echo -n "$UTXOS"
if [ "$UTXOS" -lt "$MINUTXOS" ]
   then
     echo -n " - SPLITFUNDING HUSH"
     RESULT="$(/home/$USER/nntools/acsplit.sh EMC2 $SPLITAMNT)"
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
  UTXOS="$(/usr/local/bin/komodo-cli -ac_name=${coinlist[count]} listunspent | grep $UTXOSIZE | wc -l)"
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
