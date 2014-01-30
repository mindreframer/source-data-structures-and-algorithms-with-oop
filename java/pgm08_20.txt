//
//   This file contains the Java code from Program 8.20 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm08_20.txt
//
public class OpenScatterTable
    extends AbstractHashTable
{
    protected Entry[] array;

    protected int findMatch (Comparable object)
    {
	int hash = h (object);
	for (int i = 0; i < getLength (); ++i)
	{
	    int probe = (hash + c (i)) % getLength ();
	    if (array [probe].state == empty)
		break;
	    if (array [probe].state == occupied
		&& object.isEQ (array [probe].object))
	    {
		return probe;
	    }
	}
	return -1;
    }

    public Comparable find (Comparable object)
    {
	int offset = findMatch (object);
	if (offset >= 0)
	    return array [offset].object;
	else
	    return null;
    }
    // ...
}
