//
//   This file contains the Java code from Program 3.3 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm03_03.txt
//
public class Example
{
    public static int fibonacci (int n)
    {
	int previous = -1;
	int result = 1;
	for (int i = 0; i <= n; ++i)
	{
	    int sum = result + previous;
	    previous = result;
	    result = sum;
	}
	return result;
    }
}
