//
//   This file contains the Java code from Program 15.10 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm15_10.txt
//
public class StraightSelectionSorter
    extends AbstractSorter
{
    protected void sort ()
    {
	for (int i = n; i > 1; --i)
	{
	    int max = 0;
	    for (int j = 1; j < i; ++j)
		if (array [j].isGT (array [max]))
		    max = j;
	    swap (i - 1, max);
	}
    }
}
