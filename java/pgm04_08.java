//
//   This file contains the Java code from Program 4.8 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm04_08.txt
//
public class MultiDimensionalArray
{
    int[] dimensions;
    int[] factors;
    Object[] data;

    public MultiDimensionalArray (int[] arg)
    {
	dimensions = new int[arg.length];
	factors = new int[arg.length];
	int product = 1;
	for (int i = arg.length - 1; i >= 0; --i)
	{
	    dimensions [i] = arg [i];
	    factors [i] = product;
	    product *= dimensions [i];
	}
	data = new Object[product];
    }
    // ...
}
