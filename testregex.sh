#!/bin/bash

toCheck="tx error code: -4 error message: Transaction too large"

regex="Transaction too large"

if [[ $toCheck =~ $regex ]]; then
    echo "success"
else
    echo "failed"
fi
