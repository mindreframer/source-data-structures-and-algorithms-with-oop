//
//   This file contains the Java code from Program 2.4 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm02_04.txt
//
public class Example
{
    public static int findMaximum (int[] a)
    {
	int result = a [0];
	for (int i = 1; i < a.length; ++i)
	    if (a [i] > result)
		result = a [i];
	return result;
    }
}
