#!/bin/bash

set -e

source ../cutest_variables

for p in $(cat hs.list)
do
  make PROBNAME=$p
done

set +e
