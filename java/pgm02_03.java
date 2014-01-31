//
//   This file contains the Java code from Program 2.3 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm02_03.txt
//
public class Example
{
    public static int factorial (int n)
    {
	if (n == 0)
	    return 1;
	else
	    return n * factorial (n - 1);
    }
}
