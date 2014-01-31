//
//   This file contains the Java code from Program 8.15 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm08_15.txt
//
public class ChainedScatterTable
    extends AbstractHashTable
{
    protected Entry[] array;

    public void insert (Comparable object)
    {
	if (count == getLength ())
	    throw new ContainerFullException ();
	int probe = h (object);
	if (array [probe].object != null)
	{
	    while (array [probe].next != nil)
		probe = array [probe].next;
	    int tail = probe;
	    probe = (probe + 1) % getLength ();
	    while (array [probe].object != null)
		probe = (probe + 1) % getLength ();
	    array [tail].next = probe;
	}
	array [probe].object = object;
	array [probe].next = nil;
	++count;
    }

    public Comparable find (Comparable object)
    {
	for (int probe = h (object);
	    probe != nil; probe = array [probe].next)
	{
	    if (object.isEQ (array [probe].object))
		return array [probe].object;
	}
	return null;
    }
    // ...
}
