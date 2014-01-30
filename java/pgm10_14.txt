//
//   This file contains the Java code from Program 10.14 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm10_14.txt
//
public class MWayTree
    extends AbstractTree
    implements SearchTree
{
    protected Comparable key[];
    protected MWayTree subtree[];

    public MWayTree (int m)
    {
	if (m < 2)
	    throw new IllegalArgumentException("invalid degree");
	key = new Comparable [m];
	subtree = new MWayTree [m];
    }

    int getM ()
	{ return subtree.length; }
    // ...
}
