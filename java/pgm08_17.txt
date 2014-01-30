//
//   This file contains the Java code from Program 8.17 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm08_17.txt
//
public class OpenScatterTable
    extends AbstractHashTable
{
    protected Entry[] array;

    static final int empty = 0;
    static final int occupied = 1;
    static final int deleted = 2;

    protected static final class Entry
    {
	int state = empty;
	Comparable object;

	void purge ()
	{
	    state = empty;
	    object = null;
	}
    }
    // ...
}
