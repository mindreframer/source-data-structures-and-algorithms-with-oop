//
//   This file contains the Java code from Program 9.2 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm09_02.txt
//
public abstract class AbstractTree
    extends AbstractContainer
    implements Tree
{
    public void depthFirstTraversal (PrePostVisitor visitor)
    {
	if (visitor.isDone ())
	    return;
	if (!isEmpty ())
	{
	    visitor.preVisit (getKey ());
	    for (int i = 0; i < getDegree (); ++i)
		getSubtree (i).depthFirstTraversal (visitor);
	    visitor.postVisit (getKey ());
	}
    }
    // ...
}
