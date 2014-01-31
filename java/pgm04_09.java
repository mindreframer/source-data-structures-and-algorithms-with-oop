//
//   This file contains the Java code from Program 4.9 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm04_09.txt
//
public class MultiDimensionalArray
{
    int[] dimensions;
    int[] factors;
    Object[] data;

    protected int getOffset (int[] indices)
    {
	if (indices.length != dimensions.length)
	    throw new IllegalArgumentException (
		"wrong number of indices");
	int offset = 0;
	for (int i = 0; i < dimensions.length; ++i)
	{
	    if (indices [i] < 0 || indices [i] >= dimensions [i])
		throw new IndexOutOfBoundsException ();
	    offset += factors [i] * indices [i];
	}
	return offset;
    }

    public Object get (int[] indices)
	{ return data [getOffset (indices)]; }

    public void put (int[] indices, Object object)
	{ data [getOffset (indices)] = object; }
    // ...
}
