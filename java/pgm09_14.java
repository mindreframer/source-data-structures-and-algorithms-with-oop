//
//   This file contains the Java code from Program 9.14 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm09_14.txt
//
public class GeneralTree
    extends AbstractTree
{
    protected Object key;
    protected int degree;
    protected LinkedList list;

    public GeneralTree (Object key)
    {
	this.key = key;
	degree = 0;
	list = new LinkedList ();
    }

    public void purge ()
    {
	list.purge ();
	degree = 0;
    }
    // ...
}
