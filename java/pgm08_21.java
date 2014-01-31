//
//   This file contains the Java code from Program 8.21 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm08_21.txt
//
public class OpenScatterTable
    extends AbstractHashTable
{
    protected Entry[] array;

    public void withdraw (Comparable object)
    {
	if (count == 0)
	    throw new ContainerEmptyException ();
	int offset = findInstance (object);
	if (offset < 0)
	    throw new IllegalArgumentException (
		"object not found");
	array [offset].state = deleted;
	array [offset].object = null;
	--count;
    }
    // ...
}
