//
//   This file contains the Java code from Program 15.16 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm15_16.txt
//
public class TwoWayMergeSorter
    extends AbstractSorter
{
    Comparable[] tempArray;

    protected void sort ()
    {
	tempArray = new Comparable [n];
	sort (0, n - 1);
	tempArray = null;
    }

    protected void sort (int left, int right)
    {
	if (left < right)
	{
	    int middle = (left + right) / 2;
	    sort (left, middle);
	    sort (middle + 1, right);
	    merge (left, middle, right);
	}
    }
    // ...
}
