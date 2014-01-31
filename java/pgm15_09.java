//
//   This file contains the Java code from Program 15.9 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm15_09.txt
//
public class MedianOfThreeQuickSorter
    extends AbstractQuickSorter
{
    protected int selectPivot (int left, int right)
    {
	int middle = (left + right) / 2;
	if (array [left].isGT (array [middle]))
	    swap (left, middle);
	if (array [left].isGT (array [right]))
	    swap (left, right);
	if (array [middle].isGT (array [right]))
	    swap (middle, right);
	return middle;
    }
}
