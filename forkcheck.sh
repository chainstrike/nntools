#!/bin/bash

#You can modify this list of ACs to exclude or comment out the line to show all
ignoreacs=('VOTE2018')

#how far ahead or behind before being marked as a fork
variance=3

source /home/$USER/nntools/coinlist.nr
forked=false

remotecheck=$(curl -Ssf https://komodostats.com/api/notary/summary.json)
remotecheck2=$(curl -Ssf https://dexstats.info/api/explorerstatus.php)

format="%-8s %8s %8s %8s %8s\n"
redformat="\033[0;31m$format\033[0m"
printf "$format" "-ASSET-" "-BLOCKS-" "-LONG-" "-RMT1-" "-RMT2-"

for coins in "${coinlist[@]}"; do
    coin=($coins)

    if [[ ! ${ignoreacs[*]} =~ ${coin[0]} ]]; then

        blocks=$(komodo-cli -ac_name=${coin[0]} getinfo | jq .blocks)
        longest=$(komodo-cli -ac_name=${coin[0]} getinfo | jq .longestchain)
        remoteblocks=$(echo $remotecheck | jq --arg acname ${coin[0]} '.[] | select(.ac_name==$acname) | .blocks')
        remoteblocks2=$(echo $remotecheck2 | jq --arg acname ${coin[0]} '.status[] | select(.chain==$acname) | .height | tonumber')
        diff1=$((blocks-remoteblocks))
        diff2=$((blocks-remoteblocks2))
        thisformat=$format
        if ((blocks < longest)); then
            forked=true
            thisformat=$redformat
        fi
        if (( diff1 < variance * -1 )) || (( diff1 > variance )); then
            forked=true
            thisformat=$redformat
        fi
        if (( diff2 < variance * -1 )) || (( diff2 > variance )); then
            forked=true
            thisformat=$redformat
        fi
        printf "$thisformat" "${coin[0]}" "$blocks" "$longest" "$remoteblocks" "$remoteblocks2"
    fi
done

if [ "$forked" = false ]; then
    printf "\033[0;32mAll coins are fine\033[0m\n"
else
    printf "\033[0;31mPossible fork!\033[0m\n"
fi
