#!/bin/bash

set -e

source ../cutest_variables

for p in $(cat hs.list)
do
  make decode PROBNAME=$p
  make compile
  make run
done

set +e
