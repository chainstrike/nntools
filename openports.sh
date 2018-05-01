#!/bin/bash
sudo ufw reset
sudo ufw default deny incoming

sudo ufw allow 54321 # SSH port

sudo ufw allow 7770  # KMD port
sudo ufw allow 8333  # BTC port
sudo ufw allow 57777 # CHIPS port

sudo ufw allow 7772  # Iguana port
sudo ufw allow 7773  # Iguana port
sudo ufw allow 7774  # Iguana port
sudo ufw allow 7775  # Iguana port

sudo ufw allow 17775 # Iguana (2018) port

sudo ufw allow 10195 # REVS asset chain port
sudo ufw allow 11340 # SUPERNET asset chain port
sudo ufw allow 11889 # DEX asset chain port
sudo ufw allow 14067 # PANGEA asset chain port
sudo ufw allow 15105 # JUMBLR asset chain port
sudo ufw allow 14249 # BET asset chain port
sudo ufw allow 8515  # CRYPTO asset chain port
sudo ufw allow 14430 # HODL asset chain port
sudo ufw allow 11963 # BOTS asset chain port
sudo ufw allow 12385 # MGW asset chain port
sudo ufw allow 8654  # MVP asset chain port
sudo ufw allow 12166 # WLC asset chain port
sudo ufw allow 8298  # KV asset chain port
sudo ufw allow 11115 # CEAL asset chain port
sudo ufw allow 9454  # MESH asset chain port
sudo ufw allow 14336 # MNZ asset chain port
sudo ufw allow 14275 # COQUI
sudo ufw allow 8845  # MSHARK
sudo ufw allow 12926 # AXO
sudo ufw allow 8799  # BTCH
sudo ufw allow 10270 # ETOMIC
sudo ufw allow 15487 # VOTE2018
sudo ufw allow 8426  # NINJA
sudo ufw allow 12466 # OOT
sudo ufw allow 14357 # BNTN
sudo ufw allow 15586 # CHAIN
sudo ufw allow 9678  # PRLPAY


sudo ufw enable
sudo ufw status verbose
