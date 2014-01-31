//
//   This file contains the Java code from Program 4.19 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm04_19.txt
//
public class LinkedList
{
    protected Element head;
    protected Element tail;

    public void append (Object item)
    {
	Element tmp = new Element (item, null);
	if (head == null)
	    head = tmp;
	else
	    tail.next = tmp;
	tail = tmp;
    }
    // ...
}
