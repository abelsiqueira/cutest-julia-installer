#!/bin/bash

set -e

if [ -z "$CUTEST" ]; then
  source ../cutest_variables
fi

for p in $(cat hs.list)
do
  make decode PROBNAME=$p
  make compile
  make run
  make clean
done

set +e
