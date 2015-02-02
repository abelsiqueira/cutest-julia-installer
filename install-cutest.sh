#!/bin/bash
install_dir=cutest-build
mkdir -p $install_dir

cmd="svn checkout -q --username anonymous --password ""
  --non-interactive --no-auth-cache"
url="http://ccpforge.cse.rl.ac.uk/svn/cutest/"
for name in archdefs sifdecode cutest sif
do
  $cmd $url/$name/trunk $install_dir/$name
done

cat > cutest_variables << EOF
LIBS=$install_dir
export ARCHDEFS=\$LIBS/archdefs
export SIFDECODE=\$LIBS/sifdecode
export CUTEST=\$LIBS/cutest
export MASTSIF=\$LIBS/sif
export PATH=\$CUTEST/bin:\$SIFDECODE/bin:\$PATH
export MANPATH=\$CUTEST/man:\$SIFDECODE/man:\$MANPATH
export MYARCH=pc64.lnx.gfo
export cutest_variables_loaded=true
EOF

source cutest_variables

cd $install_dir/archdefs
cat > cutest_answers << EOF
nyn6
2
n2
n3
nyyd
EOF
./install_optsuite < cutest_answers

mkdir $install_dir/tmpdir
cd $install_dir/tmpdir
runcutest -p genc -D HS35
runcutest -p gen77 -D HS35
runcutest -p gen90 -D HS35
