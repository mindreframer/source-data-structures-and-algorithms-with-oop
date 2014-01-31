//
//   This file contains the Java code from Program 8.18 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm08_18.txt
//
public class OpenScatterTable
    extends AbstractHashTable
{
    protected Entry[] array;

    public OpenScatterTable (int length)
    {
	array = new Entry [length];
	for (int i = 0; i < length; ++i)
	    array [i] = new Entry ();
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
