#!/bin/bash

who | grep "$1" | cut -c1-8 | uniq
