//
//   This file contains the Java code from Program 7.15 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm07_15.txt
//
public class OrderedListAsLinkedList
    extends AbstractSearchableContainer
    implements OrderedList
{
    protected LinkedList linkedList;

    protected class MyCursor
	implements Cursor
    {
	LinkedList.Element element;

	MyCursor (LinkedList.Element element)
	    { this.element = element; }

	public Comparable getDatum ()
	    { return (Comparable) element.getDatum (); }
	// ...
    }
    // ...
}
