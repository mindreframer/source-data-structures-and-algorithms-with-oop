//
//   This file contains the Java code from Program 2.2 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm02_02.txt
//
public class Example
{
    public static int horner (int[] a, int n, int x)
    {
	int result = a [n];
	for (int i = n - 1; i >= 0; --i)
	    result = result * x + a [i];
	return result;
    }
}
