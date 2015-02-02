SIF = ELFUN EXTER GROUP RANGE
LIB = -L$(CUTEST)/objects/$(MYARCH)/double -lcutest -lgfortran -lgfortranbegin \
			-lpthread -lm

all: sifdecode exec

sifdecode:
	@if [ -z "$(PROBNAME)" ]; then echo "Run as make PROBNAME=..." && exit 1; fi
	@echo "Decoding $(PROBNAME)"
	@$(SIFDECODE)/bin/sifdecoder $(MASTSIF)/$(PROBNAME).SIF &> /dev/null
	@gfortran -c $(addsuffix .f,$(SIF))
	@rm -f AUTOMAT.d

exec: main.o $(addsuffix .o,$(SIF))
	@gcc $^ -o main $(LIB)
	@echo "Running"
	@./main

main.o: main.c
	gcc -c -Wall -Wextra -I$(CUTEST)/include main.c -o main.o

%.o: %.f
	gfortran -c $< -o $@

clean:
	rm -f *.o $(addsuffix .f,$(SIF)) *.SIF main OUTSDIF.d
