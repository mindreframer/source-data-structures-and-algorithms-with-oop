//
//   This file contains the Java code from Program 3.5 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm03_05.txt
//
public class Example
{
    public static void bucketSort (int[] a, int m)
    {
	int[] buckets = new int[m];

	for (int j = 0; j < m; ++j)
	    buckets [j] = 0;
	for (int i = 0; i < a.length; ++i)
	    ++buckets [a [i]];
	for (int i = 0, j = 0; j < m; ++j)
	    for (int k = buckets [j]; k > 0; --k)
		a [i++] = j;
    }
}
