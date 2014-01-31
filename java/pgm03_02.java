//
//   This file contains the Java code from Program 3.2 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm03_02.txt
//
public class Example
{
    public static void prefixSums (int[] a, int n)
    {
	for (int j = n - 1; j >= 0; --j)
	{
	    int sum = 0;
	    for (int i = 0; i <= j; ++i)
		sum += a[i];
	    a [j] = sum;
	}
    }
}
