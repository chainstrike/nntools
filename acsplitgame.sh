#!/bin/bash
curl --url "http://127.0.0.1:7776" --data "{\"coin\":\""${1}"\",\"agent\":\"iguana\",\"method\":\"splitfunds\",\"satoshis\":\"100000\",\"sendflag\":1,\"duplicates\":"${2}"}"
