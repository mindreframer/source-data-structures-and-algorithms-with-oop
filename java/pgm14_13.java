//
//   This file contains the Java code from Program 14.13 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm14_13.txt
//
public final class RandomNumberGenerator
{
    private static int seed = 1;

    private static final int a = 16807;
    private static final int m = 2147483647;
    private static final int q = 127773;
    private static final int r = 2836;

    private RandomNumberGenerator ()
	{}

    public static void setSeed (int s)
    {
	if (s < 1 || s >= m)
	    throw new IllegalArgumentException ("invalid seed");
	seed = s;
    }

    public static double nextDouble ()
    {
	seed = a * (seed % q) - r * (seed / q);
	if (seed < 0)
	    seed += m;
	return (double) seed / (double) m;
    }
    // ...
}
