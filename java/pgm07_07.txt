//
//   This file contains the Java code from Program 7.7 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm07_07.txt
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

	MyCursor (int offset)
	    { this.offset = offset; }

	public Comparable getDatum ()
	{
	    if (offset < 0 || offset >= count)
		throw new IndexOutOfBoundsException ();
	    return array [offset];
	}
	// ...
    }
    // ...
}
