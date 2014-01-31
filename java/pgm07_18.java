//
//   This file contains the Java code from Program 7.18 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm07_18.txt
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

	public void withdraw ()
	{
	    linkedList.extract (element.getDatum ());
	    --count;
	}
	// ...
    }
    // ...
}
