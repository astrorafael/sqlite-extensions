
# This is an example Makefile for a countwords program.  This
# program uses both the scanner module and a counter module.
# Typing 'make' or 'make count' will create the executable file.
#

# define some Makefile variables for the compiler and compiler flags
# to use Makefile variables later in the Makefile: $()
#
#  -g    adds debugging information to the executable file
#  -Wall turns on most, but not all, compiler warnings
#
# for C++ define  CC = g++
RM = rm -f
CC = gcc
CFLAGS  = -g -Wall -fPIC -O3
LDFLAGS = -lm 

TARGET = libsqlitefunctions.so
INSTALL_DIR = /usr/local/lib 

# typing 'make' will invoke the first target entry in the file 
# (in this case the default target entry)
# you can name this target entry anything, but "default" or "all"
# are the most commonly used names by convention
#
all: $(TARGET)

# To create the executable file count we need the object files
# countwords.o, counter.o, and scanner.o:
#
$(TARGET):  extension-functions.c 
	$(CC) $(CFLAGS) -shared $< -o $@

install: all
	install --verbose --strip  --mode 0755 $(TARGET) $(INSTALL_DIR)

# To start over from scratch, type 'make clean'.  This
# removes the executable file, as well as old .o object
# files and *~ backup files:
#
clean: 
	$(RM) (TARGET) *.o *~ 