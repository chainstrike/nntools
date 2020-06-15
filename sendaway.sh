#!/bin/bash

NN_ADDRESS=RXkkdP68sha1XD43aDqM462BEMMs3tnh9y

# Set paths
KMD_PATH="$HOME/komodo/src"
komodo_cli="$KMD_PATH/komodo-cli"
komodo_daemon="$KMD_PATH/komodod"

# Never do these (see listassetchains / assetchains.json)
ignore_list=(
	KMD
)


# --------------------------------------------------------------------------
function init_colors ()
{
  RESET="\033[0m"
  BLACK="\033[30m"
  RED="\033[31m"
  GREEN="\033[32m"
  YELLOW="\033[33m"
  BLUE="\033[34m"
  MAGENTA="\033[35m"
  CYAN="\033[36m"
  WHITE="\033[37m"
}

# --------------------------------------------------------------------------
function log_print()
{
   datetime=$(date '+%Y-%m-%d %H:%M:%S')
   echo [$datetime] $1
}



function get_balance()
{
    #echo $komodo_cli $asset getbalance
    BALANCE=$($komodo_cli $asset getbalance 2>/dev/null)
    ERRORLEVEL=$?

    if [ "$ERRORLEVEL" -eq "0" ] && [ "$BALANCE" != "0.00000000" ]; then
        message=$(echo -e "(${GREEN}$coin${RESET}) $BALANCE")
        log_print "$message"
    else
        BALANCE="0.00000000"
        message=$(echo -e "(${RED}$coin${RESET}) $BALANCE")
        log_print "$message"
        exit
    fi
}

function do_send()
{
        RESULT=$($komodo_cli $asset sendtoaddress $NN_ADDRESS $BALANCE "" "" true 2>&1)
        ERRORLEVEL=$?
}

function send_balance()
{
    #if [[ ! -z $1 && $1 != "KMD" ]]
    if [ ! -z $1 ] && [ $1 != "KMD" ]
    then
        coin=$1
        asset=" -ac_name=$1"
    else
        coin="KMD"
        asset=""
    fi

        # Author: jeezy (TAB>space btw)
        # Steps: Try to send, if tx too large split into ten 10% chunks and send all, send whole balance to self again
        # Try send again
        get_balance
        log_print "$komodo_cli $asset sendtoaddress $NN_ADDRESS $BALANCE _ _ true"
        do_send
        while [ "$ERRORLEVEL" -ne "0" ]
        do
                if [[ $RESULT =~ "Transaction too large" ]]; then
                        BALANCE=$(printf %f $(bc -l <<< "scale=8;$BALANCE*0.1"))
                        log_print "TX to large. Now trying to send ten 10% chunks of $BALANCE"
                        log_print "$komodo_cli $asset sendtoaddress $NN_ADDRESS $BALANCE _ _ true"
                        counter=1
                        while [ $counter -le 10 ]
                        do
                                do_send
                                log_print "txid: $RESULT"
                                ((counter++))
                        done
                        log_print "Sending whole balance again..."
                        sleep 3
                        get_balance
                        log_print "$komodo_cli $asset sendtoaddress $NN_ADDRESS $BALANCE _ _ true"
                        do_send
                else
                        log_print "ERROR: $RESULT"
                        exit
                fi
        done
        log_print "txid: $RESULT"
    log_print "Confirmed!"
}

# --------------------------------------------------------------------------
function reset_wallet() {

    if [ ! -z $1 ] && [ $1 != "KMD" ]
    then
        coin=$1
        asset=" -ac_name=$1"
    else
        coin="KMD"
        asset=""
    fi

    log_print "Start reset ($coin) ..."


    # disable generate to avoid daemon crash during multiple "error adding notary vin" messages
    $komodo_cli $asset setgenerate false

    send_balance $coin
    log_print "ht.$height ($blockhash)"

    log_print "Done reset ($coin)"
}

####### MAIN #######
curdir=$(pwd)
init_colors

reslist=(PGT DION KSB OUR ILN RICK MORTY KOIN ZEXO THC WLC21)
for i in "${reslist[@]}"
do
        reset_wallet $i
        sleep 3
done


#${KMD_PATH}/listassetchains | while read list; do
#	if [[ "${ignore_list[@]}" =~ "${list}" ]]; then
#			continue
#	fi
#	reset_wallet $list
#	sleep 3
#done

#else
#       reset_wallet "KMD"
#fi
log_print "THE END!"
#EOF
