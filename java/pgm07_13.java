//
//   This file contains the Java code from Program 7.13 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm07_13.txt
//
public class OrderedListAsLinkedList
    extends AbstractSearchableContainer
    implements OrderedList
{
    protected LinkedList linkedList;

    public boolean isMember (Comparable object)
    {
	for (LinkedList.Element ptr = linkedList.getHead ();
		ptr != null; ptr = ptr.getNext ())
	{
	    if ((Comparable) ptr.getDatum () == object)
		return true;
	}
	return false;
    }

    public Comparable find (Comparable arg)
    {
	for (LinkedList.Element ptr = linkedList.getHead ();
	    ptr != null; ptr = ptr.getNext ())
	{
	    Comparable object = (Comparable) ptr.getDatum ();
	    if (object.isEQ (arg))
		return object;
	}
	return null;
    }
    // ...
}
