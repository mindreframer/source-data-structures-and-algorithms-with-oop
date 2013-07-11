#
#   Copyright (c) 2004 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2004/11/22 00:17:49 $
#   $RCSfile: Makefile,v $
#   $Revision: 1.2 $
#
#   $Id: Makefile,v 1.2 2004/11/22 00:17:49 brpreiss Exp $
#

.PHONY: all clean
.SUFFIXES: .c .o .so

CFLAGS=-W -Wall -Werror
CC=gcc $(CFLAGS)
LDFLAGS=-shared
LD=gcc $(LDFLAGS)
RM=rm -f

all: int.so

clean:
	$(RM) *.o *.so

int.so: int.o
	$(LD) -o $@ $^

.c.o:
	$(CC) -c $< -o $@
