//
//   This file contains the Java code from Program 15.13 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm15_13.txt
//
public class HeapSorter
    extends AbstractSorter
{
    protected static final int base = 1;

    protected void sort ()
    {
	buildHeap ();
	for (int i = n; i >= 2; --i)
	{
	    swap (i - base, 1 - base);
	    percolateDown (1, i - 1);
	}
    }
    // ...
}
