//
//   This file contains the Java code from Program 15.11 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm15_11.txt
//
public class HeapSorter
    extends AbstractSorter
{
    protected static final int base = 1;

    protected void percolateDown (int i, int length)
    {
	while (2 * i <= length)
	{
	    int j = 2 * i;
	    if (j < length &&
		    array [j + 1 - base].isGT (array [j - base]))
		j = j + 1;
	    if (array [i - base].isGE (array [j - base]))
		break;
	    swap (i - base, j - base);
	    i = j;
	}
    }
    // ...
}
