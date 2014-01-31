//
//   This file contains the Java code from Program 10.15 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm10_15.txt
//
public class MWayTree
    extends AbstractTree
    implements SearchTree
{
    protected Comparable key[];
    protected MWayTree subtree[];

    public void depthFirstTraversal (PrePostVisitor visitor)
    {
	if (!isEmpty ())
	{
	    for (int i = 0; i <= count + 1; ++i)
	    {
		if (i >= 2)
		    visitor.postVisit (key [i - 1]);
		if (i >= 1 && i <= count)
		    visitor.inVisit (key [i]);
		if (i <= count - 1)
		    visitor.preVisit (key [i + 1]);
		if (i <= count)
		    subtree [i].depthFirstTraversal (visitor);
	    }
	}
    }
    // ...
}
