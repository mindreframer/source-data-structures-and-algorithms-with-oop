//
//   This file contains the Java code from Program 7.29 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm07_29.txt
//
public class SortedListAsLinkedList
    extends OrderedListAsLinkedList
    implements SortedList
{
    public void insert (Comparable arg)
    {
	LinkedList.Element ptr;
	LinkedList.Element prevPtr = null;

	for (ptr = linkedList.getHead ();
	    ptr != null; ptr = ptr.getNext ())
	{
	    Comparable object = (Comparable) ptr.getDatum ();
	    if (object.isGE (arg))
		break;
	    prevPtr = ptr;
	}
	if (prevPtr == null)
	    linkedList.prepend (arg);
	else
	    prevPtr.insertAfter (arg);
	++count;
    }
    // ...
}
