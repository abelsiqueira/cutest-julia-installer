# CUTEst Julia Installer

This package uses an installed version of
[CUTEst](http://ccpforge.cse.rl.ac.uk/gf/project/cutest/wiki/)
to create a shared library to use with
[Julia](http://julialang.org/).

- If you do not have an installed CUTEst...

  One can be obtained using the scripts

      $ ./download-cutest.sh
      $ ./install-cutest.sh

  The first download cutest using the subversion package, and install
  it to the `cutest-build` folder inside the package folder.
  The second install CUTEst supposing you're using `gcc`, `gfortran`,
  has a 64-bit generic processor, wants double precision, is on linux,
  and possibly something else I'm forgetting.
  It creates the systems variables, saves them to `cutest_variables`
  and then install the shared version of the library.
  You will be asked for your `sudo` password, if you have one.
  After installed (if successful), copy the `cutest_variables` to your
  `.bashrc`, and source it.

- If you have an installed CUTEst...

  Verify that the variables `$CUTEST`, `$SIFDECODE` and others are
  set, then enter the folder `cutest-shared` and issue a

      $ make
      # make install

In both situations, you should have a `/usr/lib/libcutest.so` on your
system now.
To work in Julia, you still need some things compiled and linked, so
I recommend you use
[CUTEst.jl](https://github.com/abelsiqueira/CUTEst.jl).

## TODO

If you do one of these, verify that they work on travis, then
send me a pull request.

- Update the `download-cutest.sh` script to allow a folder to be passed to the
  installer, and update all other scripts, Makefiles and whatever else to not
  depend on the original location.
  Make it so that calling the script without other parameters still works.

