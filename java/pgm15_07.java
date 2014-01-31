//
//   This file contains the Java code from Program 15.7 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm15_07.txt
//
public abstract class AbstractQuickSorter
    extends AbstractSorter
{
    protected void sort (int left, int right)
    {
	if (right - left + 1 > cutOff)
	{
	    int p = selectPivot (left, right);
	    swap (p, right);
	    Comparable pivot = array [right];
	    int i = left;
	    int j = right - 1;
	    for (;;)
	    {
		while (i < j && array [i].isLT (pivot)) ++i;
		while (i < j && array [j].isGT (pivot)) --j;
		if (i >= j) break;
		swap (i++, j--);
	    }
	    if (array [i].isGT (pivot))
		swap (i, right);
	    if (left < i)
		sort (left, i - 1);
	    if (right > i)
		sort (i + 1, right);
	}
    }
    // ...
}
