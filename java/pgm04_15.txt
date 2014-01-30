//
//   This file contains the Java code from Program 4.15 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm04_15.txt
//
public class LinkedList
{
    protected Element head;
    protected Element tail;

    public void purge ()
    {
	head = null;
	tail = null;
    }
    // ...
}
