//
//   This file contains the Java code from Program 9.12 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm09_12.txt
//
public abstract class AbstractTree
    extends AbstractContainer
    implements Tree
{
    protected class TreeEnumeration
	implements Enumeration
    {
	public boolean hasMoreElements ()
	    { return !stack.isEmpty (); }

	public Object nextElement ()
	{
	    if (stack.isEmpty ())
		throw new NoSuchElementException ();

	    Tree top = (Tree) stack.pop ();
	    for (int i = top.getDegree () - 1; i >= 0; --i)
	    {
		Tree subtree = (Tree) top.getSubtree (i);
		if (!subtree.isEmpty ())
		    stack.push (subtree);
	    }
	    return top.getKey ();
	}
	// ...
    }
    // ...
}
