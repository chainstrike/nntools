#!/bin/bash

###########################
####### CONFIG HERE #######
###########################
NN_ADDRESS=RVxow6SGPCjL2TxfTcztxMWeJWgS5rZTE6
NN_PUBKEY=037f182facbad35684a6e960699f5da4ba89e99f0d0d62a87e8400dd086c8e5dd7
PAYOUT=RJEEZYoccpso3GT5BVZGn33tcWZzKsvwbV
# Set paths
KMD_PATH="$HOME/komodo/src"
komodo_cli="$KMD_PATH/komodo-cli"
komodo_daemon="$KMD_PATH/komodod"

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
###########################
####### END CONFIG  #######
###########################

function log_print()
{
   datetime=$(date '+%Y-%m-%d %H:%M:%S')
   echo [$datetime] $1
}

function wait_for_daemon()
{
	coin="KMD"
	asset=""
	i=0
	while ! $komodo_cli $asset getinfo >/dev/null 2>&1
	do
		i=$((i+1))
		log_print "Waiting for daemon start $coin ($i)"
		sleep 1
	done
}

function stop_daemon()
{
	coin="KMD"
	asset=""
	i=0
	$komodo_cli stop
	ddatadir=$HOME/.komodo
	while [ -f $ddatadir/komodod.pid ]
		do
		i=$((i+1))
		log_print "Waiting for daemon $coin stop ($i)"
		sleep 1
	done
	while [ ! -z $(lsof -Fp $ddatadir/.lock | head -1 | cut -c 2-) ]
	do
		i=$((i+1))
		log_print "Waiting for .lock release by $coin  ($i)"
		sleep 1
	done
}

function get_balance()
{
    BALANCE=$($komodo_cli getbalance 2>/dev/null)
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
        RESULT=$($komodo_cli sendtoaddress $NN_ADDRESS $BALANCE "" "" true 2>&1)
        ERRORLEVEL=$?
}

function send_balance()
{
	coin="KMD"
	asset=""
    get_balance
	log_print "Total Balance: $BALANCE"
    BALANCE=$(printf %f $(bc -l <<< "scale=8;$BALANCE*0.9"))
    log_print "$komodo_cli $asset sendtoaddress $PAYOUT $BALANCE _ _ true"
    RESULT=$($komodo_cli sendtoaddress $PAYOUT $BALANCE "" "" true 2>&1)
    i=0
    confirmations=0
	while [ "$confirmations" -eq "0" ]
	do
		confirmations=$($komodo_cli gettransaction $RESULT | jq .confirmations)
		i=$((i+1))
		log_print "Waiting for confirmations ($i).$confirmations"
		sleep 10
	done
	log_print "Confirmed! Sending rest to self and reset..."
	sleep 3
	RESULT=$($komodo_cli sendtoaddress $PAYOUT $BALANCE "" "" true 2>&1)
	do_send
	i=0
	confirmations=0
	while [ "$confirmations" -eq "0" ]
	do
		confirmations=$($komodo_cli gettransaction $RESULT | jq .confirmations)
		i=$((i+1))
		log_print "Waiting for confirmations ($i).$confirmations"
		sleep 10
	done
	blockhash=$($komodo_cli gettransaction $RESULT | jq -r .blockhash)
	height=$($komodo_cli getblock $blockhash | jq .height)
	log_print "BLOCKHASH = $blockhash"
	log_print "HEIGHT = $height"
	if [ -z "$blockhash" ] || [ -z "$height" ]
	then
		log_print "!!!ERROR!!! BLOCKHASH OR HEIGHT EMPTY - CANT CONTINUE - MAKE SURE ALL IS OK!"
		exit 1
	else
		log_print "Confirmed!"
	fi
}

# --------------------------------------------------------------------------
function reset_wallet() {
    coin="KMD"
    asset=""

    log_print "Start reset ($coin) ..."

    wait_for_daemon $coin

    log_print "Gathering pubkey ..."
    NN_PUBKEY=$($komodo_cli validateaddress $NN_ADDRESS | jq -r .pubkey)
    if [ -z $NN_PUBKEY ]
    then
        log_print "Failed to obtain pubkey. Exit"
        exit
    else
        log_print "Pubkey is $NN_PUBKEY"
    fi

    log_print "Gathering privkey ..."
    NN_PRIVKEY=$($komodo_cli dumpprivkey $NN_ADDRESS)
    if [ -z $NN_PRIVKEY ]
    then
        log_print "Failed to obtain privkey. Exit"
        exit
    else
        log_print "Privkey is obtained"
    fi

    # disable generate to avoid daemon crash during multiple "error adding notary vin" messages
    $komodo_cli $asset setgenerate false

    send_balance $coin
    log_print "ht.$height ($blockhash)"

    log_print "Stopping daemon ... "
    stop_daemon $coin

    log_print "Removing old wallet ... "
    wallet_file=backup_$(date '+%Y_%m_%d_%H%M%S').dat
    cp $HOME/.komodo/wallet.dat $HOME/.komodo/$wallet_file
    rm $HOME/.komodo/wallet.dat
    sleep 3

    log_print "Starting daemon ($coin) ... "

    # *** STARTING DAEMON ***
    $komodo_daemon -gen -genproclimit=1 -notary -pubkey="$NN_PUBKEY" &

    wait_for_daemon $coin
    log_print "Importing private key ... "
    log_print "$komodo_cli importprivkey $NN_PRIVKEY __ true $height"
    $komodo_cli importprivkey $NN_PRIVKEY "" true $height
    log_print "Done reset ($coin)"
}

####### MAIN #######
curdir=$(pwd)
init_colors
reset_wallet "KMD"
log_print "THE END!"
#EOF
