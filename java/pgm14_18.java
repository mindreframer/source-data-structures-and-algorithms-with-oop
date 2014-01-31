//
//   This file contains the Java code from Program 14.18 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm14_18.txt
//
public class Example
{
    public static double pi (int trials)
    {
	int hits = 0;
	for (int i = 0; i < trials; ++i)
	{
	    double x = RandomNumberGenerator.nextDouble ();
	    double y = RandomNumberGenerator.nextDouble ();
	    if (x * x + y * y < 1.0)
		++hits;
	}
	return 4.0 * hits / trials;
    }
}
