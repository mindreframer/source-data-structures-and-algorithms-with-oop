//
//   This file contains the Java code from Program 7.16 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm07_16.txt
//
public class OrderedListAsLinkedList
    extends AbstractSearchableContainer
    implements OrderedList
{
    protected LinkedList linkedList;

    public Cursor findPosition (Comparable arg)
    {
	LinkedList.Element ptr;
	for (ptr = linkedList.getHead ();
	    ptr != null; ptr = ptr.getNext ())
	{
	    Comparable object = (Comparable) ptr.getDatum ();
	    if (object.isEQ (arg))
		break;
	}
	return new MyCursor (ptr);
    }
    // ...
}
