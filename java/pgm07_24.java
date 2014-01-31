//
//   This file contains the Java code from Program 7.24 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm07_24.txt
//
public class SortedListAsArray
    extends OrderedListAsArray
    implements SortedList
{
    public void insert (Comparable object)
    {
	if (count == array.length)
	    throw new ContainerFullException ();
	int i = count;
	while (i > 0 && array [i - 1].isGT (object))
	{
	    array [i] = array [i - 1];
	    --i;
	}
	array [i] = object;
	++count;
    }
    // ...
}
