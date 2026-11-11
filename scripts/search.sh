#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 PATTERN FILE"
    exit 1
fi

grep "$1" "$2"
