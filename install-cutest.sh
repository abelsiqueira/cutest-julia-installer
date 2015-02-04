#!/bin/bash
install_dir=$(cat cutest_install_dir)

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

cd ../../cutest-shared
make
sudo make install
