//
//   This file contains the Java code from Program 7.10 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm07_10.txt
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

	public void withdraw ()
	{
	    if (offset < 0 || offset >= count)
		throw new IndexOutOfBoundsException ();
	    if (count == 0)
		throw new ContainerEmptyException ();

	    int i = offset;
	    while (i < count - 1)
	    {
		array [i] = array [i + 1];
		++i;
	    }
	    array [i] = null;
	    --count;
	}
	// ...
    }
    // ...
}
