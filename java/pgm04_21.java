//
//   This file contains the Java code from Program 4.21 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm04_21.txt
//
public class LinkedList
{
    protected Element head;
    protected Element tail;

    public void extract (Object item)
    {
	Element ptr = head;
	Element prevPtr = null;
	while (ptr != null && ptr.datum != item)
	{
	    prevPtr = ptr;
	    ptr = ptr.next;
	}
	if (ptr == null)
	    throw new IllegalArgumentException (
		"item not found");
	if (ptr == head)
	    head = ptr.next;
	else
	    prevPtr.next = ptr.next;
	if (ptr == tail)
	    tail = prevPtr;
    }
    // ...
}
