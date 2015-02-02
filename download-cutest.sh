#!/bin/bash
# This should work for MAC too:
install_dir=$(cd "$(dirname "$0")"; pwd)/cutest-build
mkdir -p $install_dir

cmd="svn checkout -q --username anonymous --password ""
  --non-interactive --no-auth-cache"
url="http://ccpforge.cse.rl.ac.uk/svn/cutest/"
for name in archdefs sifdecode cutest sif
do
  $cmd $url/$name/trunk $install_dir/$name
done

echo $install_dir > cutest_install_dir
