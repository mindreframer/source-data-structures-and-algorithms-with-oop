//
//   This file contains the Java code from Program 9.15 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm09_15.txt
//
public class GeneralTree
    extends AbstractTree
{
    protected Object key;
    protected int degree;
    protected LinkedList list;

    public Object getKey ()
	{ return key; }

    public Tree getSubtree (int i)
    {
	if (i < 0 || i >= degree)
	    throw new IndexOutOfBoundsException ();
	LinkedList.Element ptr = list.getHead ();
	for (int j = 0; j < i; ++j)
	    ptr = ptr.getNext ();
	return (GeneralTree) ptr.getDatum ();
    }

    public void attachSubtree (GeneralTree t)
    {
	list.append (t);
	++degree;
    }

    public GeneralTree detachSubtree (GeneralTree t)
    {
	list.extract (t);
	--degree;
	return t;
    }
    // ...
}
