//
//   This file contains the Java code from Program 15.12 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm15_12.txt
//
public class HeapSorter
    extends AbstractSorter
{
    protected static final int base = 1;

    protected void buildHeap ()
    {
	for (int i = n / 2; i > 0; --i)
	    percolateDown (i, n);
    }
    // ...
}
