//
//   This file contains the Java code from Program 14.9 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm14_09.txt
//
public class Example
{
    public static void mergeSort (
	Comparable[] array, int i, int n)
    {
	if (n > 1)
	{
	    mergeSort (array, i, n / 2);
	    mergeSort (array, i + n / 2, n - n / 2);
	    merge (array, i, n / 2, n - n / 2);
	}
    }
}
