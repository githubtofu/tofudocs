#!/usr/bin/env bash

awk -v date=0 'NR>1{if(date!=$1) print last_line;} {date=$1;last_line=$0}END{print last_line}' "$TOFU_PATH/daily/renderedf"
