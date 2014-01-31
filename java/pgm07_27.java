//
//   This file contains the Java code from Program 7.27 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm07_27.txt
//
public class SortedListAsArray
    extends OrderedListAsArray
    implements SortedList
{
    public void withdraw (Comparable object)
    {
	if (count == 0)
	    throw new ContainerEmptyException ();

	int offset = findOffset (object);

	if (offset < 0)
	    throw new IllegalArgumentException (
		"object not found");

	int i;
	for (i = offset; i < count - 1; ++i)
	    array [i] = array [i + 1];
	array [i] = null;
	--count;
    }
    // ...
}
