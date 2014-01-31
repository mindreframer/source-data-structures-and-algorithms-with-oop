//
//   This file contains the Java code from Program 7.9 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm07_09.txt
//
public class OrderedListAsArray
    extends AbstractSearchableContainer
    implements OrderedList
{
    protected Comparable[] array;

    protected class MyCursor
	implements Cursor
    {
	int offset;

	public void insertAfter (Comparable object)
	{
	    if (offset < 0 || offset >= count)
		throw new IndexOutOfBoundsException ();
	    if (count == array.length)
		throw new ContainerFullException ();

	    int insertPosition = offset + 1;

	    for (int i = count; i > insertPosition; --i)
		array [i] = array [i - 1];
	    array [insertPosition] = object;
	    ++count;
	}
	// ...
    }
    // ...
}
