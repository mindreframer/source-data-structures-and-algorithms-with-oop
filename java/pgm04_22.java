//
//   This file contains the Java code from Program 4.22 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm04_22.txt
//
public class LinkedList
{
    protected Element head;
    protected Element tail;

    public final class Element
    {
	Object datum;
	Element next;

	public void insertAfter (Object item)
	{
	    next = new Element (item, next);
	    if (tail == this)
		tail = next;
	}

	public void insertBefore (Object item)
	{
	    Element tmp = new Element (item, this);
	    if (this == head)
		head = tmp;
	    else
	    {
		Element prevPtr = head;
		while (prevPtr != null && prevPtr.next != this)
		    prevPtr = prevPtr.next;
		prevPtr.next = tmp;
	    }
	}
	// ...
    }
    // ...
}
