//
//   This file contains the Java code from Program 14.8 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm14_08.txt
//
public class Example
{
    public static int fibonacci (int n)
    {
	if (n == 0 || n == 1)
	    return n;
	else
	{
	    int a = fibonacci ((n + 1) / 2);
	    int b = fibonacci ((n + 1) / 2 - 1);
	    if (n % 2 == 0)
		return a * (a + 2 * b);
	    else
		return a * a + b * b;
	}
    }
}
