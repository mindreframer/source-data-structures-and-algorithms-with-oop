//
//   This file contains the Java code from Program 15.15 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm15_15.txt
//
public class TwoWayMergeSorter
    extends AbstractSorter
{
    Comparable[] tempArray;

    protected void merge (int left, int middle, int right)
    {
	int i = left;
	int j = left;
	int k = middle + 1;
	while (j <= middle && k <= right)
	{
	    if (array [j].isLT (array [k]))
		tempArray [i++] = array [j++];
	    else
		tempArray [i++] = array [k++];
	}
	while (j <= middle)
	    tempArray [i++] = array [j++];
	for (i = left; i < k; ++i)
	    array [i] = tempArray [i];
    }
    // ...
}
