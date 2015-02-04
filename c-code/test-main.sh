#!/bin/bash

set -e

if [ -z "$CUTEST" ]; then
  source ../cutest_variables
fi

for p in $(cat hs.list)
do
  make PROBNAME=$p
done

set +e
