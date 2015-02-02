#!/bin/bash

set -e

source cutest_variables

mkdir -p tmpdir
cd tmpdir

runcutest -p genc -D HS35
runcutest -p gen77 -D HS35
runcutest -p gen90 -D HS35

cd ..

set +e
