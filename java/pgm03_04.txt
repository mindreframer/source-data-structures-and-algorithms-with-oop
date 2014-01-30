//
//   This file contains the Java code from Program 3.4 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm03_04.txt
//
public class Example
{
    public static int fibonacci (int n)
    {
	if (n == 0 || n == 1)
	    return n;
	else
	    return fibonacci (n - 1) + fibonacci (n - 2);
    }
}
