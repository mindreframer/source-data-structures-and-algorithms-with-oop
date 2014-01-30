//
//   This file contains the Java code from Program 2.5 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm02_05.txt
//
public class Example
{
    public static double gamma ()
    {
	double result = 0;
	for (int i = 1; i <= 500000; ++i)
	    result += 1./i - Math.log ((i + 1.)/i);
	return result;
    }
}
