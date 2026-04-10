FC = gfortran
FFLAGS = -Wall -Wextra -O2
TARGET = spire
DATA = spire_points.dat

# IMPORTANT: The order here doesn't strictly matter for the list, 
# but the dependency rules below do.
OBJS = params.o geometry.o main.o

all: $(TARGET)

$(TARGET): $(OBJS)
	$(FC) -o $@ $^

# 1. Compile params first
params.o: params.f90
	$(FC) $(FFLAGS) -c $< -o $@

# 2. Geometry depends on params.o being finished
geometry.o: geometry.f90 params.o
	$(FC) $(FFLAGS) -c $< -o $@

# 3. Main depends on both
main.o: main.f90 geometry.o params.o
	$(FC) $(FFLAGS) -c $< -o $@

run: $(TARGET)
	./$(TARGET)

clean:
	rm -f *.o $(TARGET) $(DATA) *.mod

.PHONY: all run clean
