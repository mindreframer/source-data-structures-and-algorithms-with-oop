//
//   This file contains the Java code from Program 2.1 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm02_01.txt
//
public class Example
{
    public static int sum (int n)
    {
	int result = 0;
	for (int i = 1; i <= n; ++i)
	    result += i;
	return result;
    }
}
