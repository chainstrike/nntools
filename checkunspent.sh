#!/bin/bash
bitcoin-cli listunspent | grep 0.0005 | wc
#bitcoin-cli listunspent | grep 0.0001 | wc
