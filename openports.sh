#!/bin/bash
sudo ufw reset
sudo ufw default deny incoming

sudo ufw allow 54321 # SSH port

sudo ufw allow 7770  # KMD port
sudo ufw allow 8333  # BTC port
sudo ufw allow 57777 # CHIPS port

#sudo ufw allow 7772  # KMD THIRD PARTY
sudo ufw allow 7773  # Iguana port
sudo ufw allow 7774  # Iguana port
sudo ufw allow 7775  # Iguana port

sudo ufw allow 17775 # Iguana (2019)
sudo ufw allow 17776 # Iguana (2019) THIRD PARTY

sudo ufw allow 18030 # HUSH3
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
sudo ufw allow 19711 # COQUICASH
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
sudo ufw allow 11556 # DSEC
sudo ufw allow 15722 # GLXT
sudo ufw allow 10305 # EQL
sudo ufw allow 10040 # ZILLA
sudo ufw allow 32268 # RFOX
sudo ufw allow 27485 # VRSC
sudo ufw allow 11539 # SEC
sudo ufw allow 20848 # CCL
sudo ufw allow 45452 # PIRATE
sudo ufw allow 20730 # MGNX
sudo ufw allow 46704 # PGT
sudo ufw allow 30176 # KMDICE
sudo ufw allow 23894 # DION
sudo ufw allow 21065 # KSB
sudo ufw allow 45671 # OUR
sudo ufw allow 12985 # ILN
sudo ufw allow 28222 # RICK
sudo ufw allow 63811 # MORTY
sudo ufw allow 10701 # KOIN
sudo ufw allow 33969 # ZEXO
sudo ufw allow 12244 # K64

sudo ufw enable
sudo ufw status verbose
