//
//   This file contains the Java code from Program 12.4 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm12_04.txt
//
public class SetAsArray
    extends AbstractSet
    implements Set
{
    protected boolean[] array;

    public SetAsArray (int n)
    {
	super (n);
	array = new boolean [universeSize];
	for (int item = 0; item < universeSize; ++item)
	    array [item] = false;
    }

    protected void insert (int item)
	{ array [item] = true; }

    protected boolean isMember (int item)
	{ return array [item]; }

    protected void withdraw (int item)
	{ array [item] = false; }
    // ...
}
