//
//   This file contains the Java code from Program 7.8 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm07_08.txt
//
public class OrderedListAsArray
    extends AbstractSearchableContainer
    implements OrderedList
{
    protected Comparable[] array;

    public Cursor findPosition (Comparable object)
    {
	int i = 0;
	while (i < count && array [i].isNE (object))
	    ++i;
	return new MyCursor (i);
    }

    public Comparable get (int offset)
    {
	if (offset < 0 || offset >= count)
	    throw new IndexOutOfBoundsException ();
	return array [offset];
    }
    // ...
}
