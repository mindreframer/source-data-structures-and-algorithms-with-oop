//
//   This file contains the Java code from Program 8.19 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm08_19.txt
//
public class OpenScatterTable
    extends AbstractHashTable
{
    protected Entry[] array;

    protected static int c (int i)
	{ return i; }

    protected int findUnoccupied (Object object)
    {
	int hash = h (object);
	for (int i = 0; i < count + 1; ++i)
	{
	    int probe = (hash + c (i)) % getLength ();
	    if (array [probe].state != occupied)
		return probe;
	}
	throw new ContainerFullException ();
    }

    public void insert (Comparable object)
    {
	if (count == getLength ())
	    throw new ContainerFullException ();
	int offset = findUnoccupied (object);
	array [offset].state = occupied;
	array [offset].object = object;
	++count;
    }
    // ...
}
