//
//   This file contains the Java code from Program 7.25 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm07_25.txt
//
public class SortedListAsArray
    extends OrderedListAsArray
    implements SortedList
{
    protected int findOffset (Comparable object)
    {
	int left = 0;
	int right = count - 1;

	while (left <= right)
	{
	    int middle = (left + right) / 2;

	    if (object.isGT (array [middle]))
		left = middle + 1;
	    else if (object.isLT (array [middle]))
		right = middle - 1;
	    else
		return middle;
	}
	return -1;
    }
    // ...
}
