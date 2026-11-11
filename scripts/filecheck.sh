#!/bin/bash

if [ -f "$1" ]; then
    echo "$1 is a regular file"
else
    echo "$1 is not a regular file"
fi
