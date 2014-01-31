//
//   This file contains the Java code from Program 10.16 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm10_16.txt
//
public class MWayTree
    extends AbstractTree
    implements SearchTree
{
    protected Comparable key[];
    protected MWayTree subtree[];

    public Comparable find (Comparable object)
    {
	if (isEmpty ())
	    return null;
	int i;
	for (i = count; i > 0; --i)
	{
	    int diff = object.compare (key [i]);
	    if (diff == 0)
		return key [i];
	    if (diff > 0)
		break;
	}
	return subtree [i].find (object);
    }
    // ...
}
