//
//   This file contains the Java code from Program 7.26 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm07_26.txt
//
public class SortedListAsArray
    extends OrderedListAsArray
    implements SortedList
{
    public Comparable find (Comparable object)
    {
	int offset = findOffset (object);

	if (offset >= 0)
	    return array [offset];
	else
	    return null;
    }

    public Cursor findPosition (Comparable object)
    {
	return new MyCursor (findOffset (object))
	{
	    public void insertAfter (Comparable object)
		{ throw new InvalidOperationException (); }
	    public void insertBefore (Comparable object)
		{ throw new InvalidOperationException (); }
	};
    }
    // ...
}
