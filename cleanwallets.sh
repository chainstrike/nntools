#!/bin/bash
#
# @author webworker01
#scriptpath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

source $HOME/nntools/coinlist
source $HOME/node.conf

#echo $komodo_cli

dt=$(date '+%Y-%m-%d %H:%M:%S');

echo "KMD"
$komodo_cli cleanwallettransactions | jq -r .removed_transactions
#if ($cleanerremoved > 0); then
#    echo "$dt [cleanwallettransactions] KMD - Removed $cleanerremoved transactions" >> $nntoolslogfile
#fi

$HOME/komodo/src/listassetchains | while read list; do
	if [[ "${ignoreacs[@]}" =~ "${list}" ]]; then
		continue
        fi
        echo $list
        $komodo_cli -ac_name=$list cleanwallettransactions | jq -r .removed_transactions
done


#if (( thirdpartycoins < 1 )); then
#    for coins in "${coinlist[@]}"; do
#        coin=($coins)
#        if [[ ! ${ignoreacs[*]} =~ ${coin[0]} ]]; then
#            echo ${coin[0]}
#            $komodo_cli -ac_name=${coin[0]} cleanwallettransactions | jq -r .removed_transactions
#            if ($cleanerremoved > "0"); then
#                echo "$dt [cleanwallettransactions] ${coin[0]} - Removed $cleanerremoved transactions" >> $nntoolslogfile
#            fi
#        fi
#    done
#fi
