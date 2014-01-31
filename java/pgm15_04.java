//
//   This file contains the Java code from Program 15.4 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm15_04.txt
//
public class BinaryInsertionSorter
    extends AbstractSorter
{
    protected void sort ()
    {
	for (int i = 1; i < n; ++i)
	{
	    Comparable tmp = array [i];
	    int left = 0;
	    int right = i;
	    while (left < right)
	    {
		int middle = (left + right) / 2;
		if (tmp.isGE (array [middle]))
		    left = middle + 1;
		else
		    right = middle;
	    }
	    for (int j = i; j > left; --j)
		swap (j - 1, j);
	}
    }
}
