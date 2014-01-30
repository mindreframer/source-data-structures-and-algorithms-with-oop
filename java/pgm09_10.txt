//
//   This file contains the Java code from Program 9.10 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm09_10.txt
//
public abstract class AbstractTree
    extends AbstractContainer
    implements Tree
{
    public Enumeration getEnumeration ()
	{ return new TreeEnumeration (); }

    protected class TreeEnumeration
	implements Enumeration
    {
	protected Stack stack;

	// ...
    }
    // ...
}
