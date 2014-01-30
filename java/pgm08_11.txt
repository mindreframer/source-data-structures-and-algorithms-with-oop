//
//   This file contains the Java code from Program 8.11 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm08_11.txt
//
public class ChainedHashTable
    extends AbstractHashTable
{
    protected LinkedList[] array;

    public Comparable find (Comparable object)
    {
	for (LinkedList.Element ptr = array[h(object)].getHead();
	    ptr != null; ptr = ptr.getNext())
	{
	    Comparable datum = (Comparable) ptr.getDatum ();
	    if (object.isEQ (datum))
		return datum;
	}
	return null;
    }
    // ...
}
