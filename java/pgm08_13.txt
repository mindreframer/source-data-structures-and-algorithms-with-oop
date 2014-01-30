//
//   This file contains the Java code from Program 8.13 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm08_13.txt
//
public class ChainedScatterTable
    extends AbstractHashTable
{
    protected Entry[] array;

    static final int nil = -1;

    protected static final class Entry
    {
	Comparable object;
	int next = nil;

	void purge ()
	{
	    object = null;
	    next = nil;
	}
    }
    // ...
}
