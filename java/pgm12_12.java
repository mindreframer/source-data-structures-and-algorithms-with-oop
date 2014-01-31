//
//   This file contains the Java code from Program 12.12 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm12_12.txt
//
public class MultisetAsArray
    extends AbstractSet
    implements Multiset
{
    protected int[] array;

    public MultisetAsArray (int n)
    {
	super (n);
	array = new int[universeSize];
	for (int item = 0; item < universeSize; ++item)
	    array [item] = 0;
    }

    protected void insert (int item)
	{ ++array [item]; }

    protected void withdraw (int item)
    {
	if (array [item] > 0)
	    --array [item];
    }

    protected boolean isMember (int item)
	{ return array [item] > 0; }
    // ...
}
