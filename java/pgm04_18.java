//
//   This file contains the Java code from Program 4.18 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm04_18.txt
//
public class LinkedList
{
    protected Element head;
    protected Element tail;

    public void prepend (Object item)
    {
	Element tmp = new Element (item, head);
	if (head == null)
	    tail = tmp;
	head = tmp;
    }
    // ...
}
