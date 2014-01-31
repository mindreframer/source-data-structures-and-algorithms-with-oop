//
//   This file contains the Java code from Program 4.13 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm04_13.txt
//
public class LinkedList
{
    protected Element head;
    protected Element tail;

    public final class Element
    {
	Object datum;
	Element next;

	Element (Object datum, Element next)
	{
	    this.datum = datum;
	    this.next = next;
	}

	public Object getDatum ()
	    { return datum; }

	public Element getNext ()
	    { return next; }
	// ...
    }
    // ...
}
