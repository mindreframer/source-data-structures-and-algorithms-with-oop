//
//   This file contains the Java code from Program 6.3 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm06_03.txt
//
public class StackAsArray
    extends AbstractContainer
    implements Stack
{
    protected Object[] array;

    public StackAsArray (int size)
	{ array = new Object [size]; }

    public void purge ()
    {
	while (count > 0)
	    array [--count] = null;
    }
    // ...
}
