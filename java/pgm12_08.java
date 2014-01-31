//
//   This file contains the Java code from Program 12.8 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm12_08.txt
//
public class SetAsBitVector
    extends AbstractSet
    implements Set
{
    protected int[] vector;

    public SetAsBitVector (int n)
    {
	super (n);
	vector  = new int [(n + intBits - 1) / intBits];
	for (int i = 0; i < vector.length; ++i)
	    vector [i] = 0;
    }

    protected void insert (int item)
    {
	vector [item / intBits] |= 1 << item % intBits;
    }

    protected void withdraw (int item)
    {
	vector [item / intBits] &= ~(1 << item % intBits);
    }

    protected boolean isMember (int item)
    {
	return (vector [item / intBits] &
	    (1 << item % intBits)) != 0;
    }
    // ...
}
