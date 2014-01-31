//
//   This file contains the Java code from Program 15.3 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm15_03.txt
//
public class StraightInsertionSorter
    extends AbstractSorter
{
    protected void sort ()
    {
	for (int i = 1; i < n; ++i)
	    for (int j = i;
		j > 0 && array [j - 1].isGT (array [j]); --j)
	    {
		swap (j, j - 1);
	    }
    }
}
