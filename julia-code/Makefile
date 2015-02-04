ifndef PROBNAME
decode:
	$(error "make should be called as `make PROBNAME=...`")
else
decode:
	sifdecoder $(PROBNAME)
endif

compile:
	for file in *.f; do gfortran -c -o $${file//.f/.o} $$file -fPIC; done
	ld -shared -o libjuliacutest.so *.o -lcutest -lgfortran

run:
	LD_LIBRARY_PATH=. julia main.jl

clean purge:
	rm -f *.f *.o *.d *.so
