FC = gfortran
TOOLS = $(shell ls $(CUTEST)/src/tools/{c,u}*.f90)
OBJS = $(patsubst %.f90,%.o,$(TOOLS))

all: cutest.mod $(OBJS)
	ld -shared -o libcutest.so $(notdir $(OBJS))

cutest.mod:
	cp $(CUTEST)/modules/$(MYARCH)/double/cutest.mod .

%.o: %.f90
	$(FC) -c -o $(shell basename $@) -fPIC $<

clean purge:
	rm -f *.o libcutest.so cutest.mod
