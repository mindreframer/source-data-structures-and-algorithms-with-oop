//
//   This file contains the Java code from Program 2.7 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm02_07.txt
//
public class Example
{
    public static int geometricSeriesSum (int x, int n)
    {
	int sum = 0;
	for (int i = 0; i <= n; ++i)
	    sum = sum * x + 1;
	return sum;
    }
}
