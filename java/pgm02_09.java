//
//   This file contains the Java code from Program 2.9 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm02_09.txt
//
public class Example
{
    public static int geometricSeriesSum (int x, int n)
    {
	return (power (x, n + 1) - 1) / (x - 1);
    }
}
