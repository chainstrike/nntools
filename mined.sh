komodo-cli listtransactions "*" 100 0
komodo-cli listtransactions "*" 100 0 | egrep "generate\"|immature" -A 3 | grep confirmations
