//
//   This file contains the Java code from Program 7.6 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm07_06.txt
//
public class OrderedListAsArray
    extends AbstractSearchableContainer
    implements OrderedList
{
    protected Comparable[] array;

    public void withdraw (Comparable object)
    {
	if (count == 0)
	    throw new ContainerEmptyException ();
	int i = 0;
	while (i < count && array [i] != object)
	    ++i;
	if (i == count)
	    throw new IllegalArgumentException (
		"object not found");
	for ( ; i < count - 1; ++i)
	    array [i] = array [i + 1];
	array [i] = null;
	--count;
    }
    // ...
}
