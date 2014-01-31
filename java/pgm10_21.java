//
//   This file contains the Java code from Program 10.21 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm10_21.txt
//
public class BTree
    extends MWayTree
{
    protected BTree parent;

    public void insert (Comparable object)
    {
	if (isEmpty ())
	{
	    if (parent == null)
	    {
		attachSubtree (0, new BTree (getM ()));
		key [1] = object;
		attachSubtree (1, new BTree (getM ()));
		count = 1;
	    }
	    else
		parent.insertPair (object, new BTree (getM ()));
	}
	else
	{
	    int index = findIndex (object);
	    if (index != 0 && object.isEQ (key [index]))
		throw new IllegalArgumentException (
		    "duplicate key");
	    subtree [index].insert (object);
	}
    }
    // ...
}
