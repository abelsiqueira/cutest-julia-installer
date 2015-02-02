#!/bin/bash

set -e

for p in $(cat hs.list)
do
  make PROBNAME=$p
done

set +e
