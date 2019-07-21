#!/bin/bash
#
# @author webworker01
#scriptpath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

source $HOME/nntools/coinlist
source $HOME/node.conf

#echo $komodo_cli

dt=$(date '+%Y-%m-%d %H:%M:%S');

$komodo_cli cleanwallettransactions | jq -r .removed_transactions
#if ($cleanerremoved > 0); then
#    echo "$dt [cleanwallettransactions] KMD - Removed $cleanerremoved transactions" >> $nntoolslogfile
#fi

if (( thirdpartycoins < 1 )); then
    for coins in "${coinlist[@]}"; do
        coin=($coins)
        if [[ ! ${ignoreacs[*]} =~ ${coin[0]} ]]; then
            echo ${coin[0]}
            $komodo_cli -ac_name=${coin[0]} cleanwallettransactions | jq -r .removed_transactions
#            if ($cleanerremoved > "0"); then
#                echo "$dt [cleanwallettransactions] ${coin[0]} - Removed $cleanerremoved transactions" >> $nntoolslogfile
#            fi
        fi
    done
fi
