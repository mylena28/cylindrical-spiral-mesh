FC = gfortran
FFLAGS = -Wall -Wextra -O2
TARGET = spire
DATA = spire_points.dat

# Order matters: geometry.f90 must be compiled first (produces .mod)
OBJS = geometry.o main.o

all: $(TARGET)

$(TARGET): $(OBJS)
	$(FC) -o $@ $^

geometry.o: geometry.f90
	$(FC) $(FFLAGS) -c $< -o $@

main.o: main.f90 geometry.o
	$(FC) $(FFLAGS) -c $< -o $@

run: $(TARGET)
	./$(TARGET)

clean:
	rm -f $(OBJS) $(TARGET) $(DATA) *.mod

.PHONY: all run clean
