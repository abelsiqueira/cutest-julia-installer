FC = gfortran
CC = gcc
CTOOLS = $(shell ls $(CUTEST)/src/tools/c*.f90)
UTOOLS = $(shell ls $(CUTEST)/src/tools/u*.f90)
BASICTOOLS = $(patsubst %,$(CUTEST)/src/tools/%.f90,pname probname \
						 varnames newthread problem fortran_ops interface)
TOOLS = $(CTOOLS) $(UTOOLS) $(BASICTOOLS)
OBJS = $(patsubst %.f90,%.o,$(TOOLS)) $(CUTEST)/src/tools/ccutest.o

all: cutest.mod $(OBJS)
	ld -shared -o libcutest.so $(notdir $(OBJS))

cutest.mod:
	cp $(CUTEST)/modules/$(MYARCH)/double/cutest.mod .

%.o: %.f90
	$(FC) -c -o $(shell basename $@) -fPIC $<

%.o: %.c
	$(CC) -c -o $(shell basename $@) -I$(CUTEST)/include -fPIC $<

clean purge:
	rm -f *.o libcutest.so *.mod
