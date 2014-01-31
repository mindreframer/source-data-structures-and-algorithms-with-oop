//
//   This file contains the Java code from Program 8.9 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm08_09.txt
//
public class ChainedHashTable
    extends AbstractHashTable
{
    protected LinkedList[] array;

    public ChainedHashTable (int length)
    {
	array = new LinkedList [length];
	for (int i = 0; i < length; ++i)
	    array [i] = new LinkedList ();
    }

    public int getLength ()
	{ return array.length; }

    public void purge ()
    {
	for (int i = 0; i < getLength (); ++i)
	    array [i].purge ();
	count = 0;
    }
    // ...
}
