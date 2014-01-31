//
//   This file contains the Java code from Program 9.11 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm09_11.txt
//
public abstract class AbstractTree
    extends AbstractContainer
    implements Tree
{
    protected class TreeEnumeration
	implements Enumeration
    {
	public TreeEnumeration ()
	{
	    stack = new StackAsLinkedList ();
	    if (!isEmpty ())
		stack.push (AbstractTree.this);
	}
	// ...
    }
    // ...
}
