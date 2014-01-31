//
//   This file contains the Java code from Program 10.18 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm10_18.txt
//
public class MWayTree
    extends AbstractTree
    implements SearchTree
{
    protected Comparable key[];
    protected MWayTree subtree[];

    public void insert (Comparable object)
    {
	if (isEmpty ())
	{
	    subtree [0] = new MWayTree (getM ());
	    key [1] = object;
	    subtree [1] = new MWayTree (getM ());
	    count = 1;
	}
	else
	{
	    int index = findIndex (object);
	    if (index != 0 && object.isEQ (key [index]))
		throw new IllegalArgumentException (
		    "duplicate key");
	    if (!isFull ())
	    {
		for (int i = count; i > index; --i)
		{
		    key [i + 1] = key [i];
		    subtree [i + 1] = subtree [i];
		}
		key [index + 1] = object;
		subtree [index + 1] = new MWayTree (getM ());
		++count;
	    }
	    else
		subtree [index].insert (object);
	}
    }
    // ...
}
