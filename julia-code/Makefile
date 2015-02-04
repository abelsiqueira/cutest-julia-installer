ifndef PROBNAME
decode:
	$(error "make should be called as `make PROBNAME=...`")
else
decode:
	sifdecoder $(PROBNAME)
endif

SIF = ELFUN.o EXTER.o GROUP.o RANGE.o
LIBNAME = libjuliacutest.so

compile: $(LIBNAME)

$(LIBNAME): $(SIF)
	ld -shared -o libjuliacutest.so *.o -lcutest -lgfortran

%.o: %.f
	gfortran -c -o $@ $< -fPIC

run:
	LD_LIBRARY_PATH=. julia main.jl

clean purge:
	rm -f *.f *.o *.d *.so
