FC = gfortran
CC = gcc

ifdef CUTEST
	CTOOLS = $(shell ls $(CUTEST)/src/tools/c*.f90)
	UTOOLS = $(shell ls $(CUTEST)/src/tools/u*.f90)
	BASICTOOLS = $(patsubst %,$(CUTEST)/src/tools/%.f90,pname probname \
						 varnames newthread problem fortran_ops interface)
	TOOLS = $(CTOOLS) $(UTOOLS) $(BASICTOOLS)
	OBJS = $(patsubst %.f90,%.o,$(TOOLS)) $(CUTEST)/src/tools/ccutest.o
endif

libcutest.so: cutest.mod $(OBJS)
	ld -shared -o libcutest.so $(notdir $(OBJS))

install: libcutest.so
	cp -f libcutest.so /usr/lib/

cutest.mod:
	cp $(CUTEST)/modules/$(MYARCH)/double/cutest.mod .

%.o: %.f90
	$(FC) -c -o $@ -fPIC $<

%.o: %.c
	$(CC) -c -o $@ -I$(CUTEST)/include -fPIC $<

clean purge:
	rm -f *.o libcutest.so *.mod
