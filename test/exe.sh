#!/bin/bash

#
# Test daemon
#

OUT_FILE=/tmp/test-out.log

[[ -f $OUT_FILE ]] && truncate -s 0 $OUT_FILE

exec 3>$OUT_FILE

for (( i=0 ; i<10 ; i++ )); do
  echo $i
  echo $i >&3
  sleep 1
done

exec 3>&-
