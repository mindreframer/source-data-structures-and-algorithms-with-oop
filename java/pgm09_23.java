//
//   This file contains the Java code from Program 9.23 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm09_23.txt
//
public class BinaryTree
    extends AbstractTree
{
    protected Object key;
    protected BinaryTree left;
    protected BinaryTree right;

    public void depthFirstTraversal (PrePostVisitor visitor)
    {
	if (!isEmpty ())
	{
	    visitor.preVisit (key);
	    left.depthFirstTraversal (visitor);
	    visitor.inVisit (key);
	    right.depthFirstTraversal (visitor);
	    visitor.postVisit (key);
	}
    }
    // ...
}
