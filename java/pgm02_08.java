//
//   This file contains the Java code from Program 2.8 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm02_08.txt
//
public class Example
{
    public static int power (int x, int n)
    {
	if (n == 0)
	    return 1;
	else if (n % 2 == 0) // n is even
	    return power (x * x, n / 2);
	else // n is odd
	    return x * power (x * x, n / 2);
    }
}
