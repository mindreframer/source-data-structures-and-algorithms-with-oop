//
//   This file contains the Java code from Program 4.23 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm04_23.txt
//
public class LinkedList
{
    protected ListElement head;
    protected ListElement tail;

    public void InsertAfter (ListElement ptr, Object item)
    {
	if (ptr == null)
	    throw new IllegalArgumentException (
		"invalid position");
	ListElement tmp = new ListElement (item, ptr.next);
	ptr.next = tmp;
	if (tail == ptr)
	    tail = tmp;
    }

    public void InsertBefore (ListElement ptr, Object item)
    {
	if (ptr == null)
	    throw new IllegalArgumentException (
		"invalid position");
	ListElement tmp = new ListElement (item, ptr);
	if (head == ptr)
	    head = tmp;
	else
	{
	    ListElement prevPtr = head;
	    while (prevPtr != null && prevPtr.next != ptr)
		prevPtr = prevPtr.next;
	    if (prevPtr == null)
		throw new IllegalArgumentException (
		    "invalid position");
	    prevPtr.next = tmp;
	}
    }
    // ...
}
