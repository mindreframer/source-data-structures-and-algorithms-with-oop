//
//   This file contains the Java code from Program 7.5 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm07_05.txt
//
public class OrderedListAsArray
    extends AbstractSearchableContainer
    implements OrderedList
{
    protected Comparable[] array;

    public boolean isMember (Comparable object)
    {
	for (int i = 0; i < count; ++i)
	    if (array [i] == object)
		return true;
	return false;
    }

    public Comparable find (Comparable arg)
    {
	for (int i = 0; i < count; ++i)
	    if (array [i].isEQ (arg))
		return array [i];
	return null;
    }
    // ...
}
