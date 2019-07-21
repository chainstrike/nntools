#!/bin/bash

#How many transactions back to scan for notarizations
txscanamount=50

#Only count KMD->BTC after this timestamp (block 814000)
timefilter=1563195060

# Season 2 start
#1525032458
# Season 3 start
#1563195060

btcntrzaddr=1P3rU1Nk1pmc2BiWC8dEy9bZa1ZbMp5jfg

timeSince()
{
    local currentimestamp=$(date +%s)
    local timecompare=$1

    if [ ! -z $timecompare ] && [[ $timecompare != "null" ]]
    then
        local t=$((currentimestamp-timecompare))

        local d=$((t/60/60/24))
        local h=$((t/60/60%24))
        local m=$((t/60%60))
        local s=$((t%60))

        if [[ $d > 0 ]]; then
            echo -n "${d}d"
        fi
        if [[ $h > 0 ]]; then
            echo -n "${h}h"
        fi
        if [[ $d = 0 && $m > 0 ]]; then
            echo -n "${m}m"
        fi
        if [[ $d = 0 && $h = 0 && $m = 0 ]]; then
            echo -n "${s}s"
        fi

    fi
}

notarizations=($(bitcoin-cli listtransactions "" $txscanamount | jq -r --arg address "$btcntrzaddr" --arg timefilter $timefilter '[.[] | select(.time>=($timefilter|tonumber) and .address==$address and .category=="send")] | .[].time'))

echo "=== BTC NOTARIZATIONS ==="
for (( i=${#notarizations[@]}-1 ; i>=0 ; i-- ))
do
    timestamp=$(echo notarizations[i] | sed 's/,//')
    echo $(timeSince $timestamp)
done
