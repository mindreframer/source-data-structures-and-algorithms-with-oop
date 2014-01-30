//
//   This file contains the Java code from Program 14.7 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm14_07.txt
//
public class Example
{
    public static int binarySearch (
	Comparable[] array, Comparable target, int i, int n)
    {
	if (n == 0)
	    throw new IllegalArgumentException ("empty array");
	if (n == 1)
	{
	    if (array [i].isEQ (target))
		return i;
	    throw new IllegalArgumentException (
		"target not found");
	}
	else
	{
	    int j = i + n / 2;
	    if (array [j].isLE (target))
		return binarySearch (array, target, j, n - n/2);
	    else
		return binarySearch (array, target, i, n/2);
	}
    }
}
