//
//   This file contains the Java code from Program 6.18 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm06_18.txt
//
public class QueueAsLinkedList
    extends AbstractContainer
    implements Queue
{
    protected LinkedList list;

    public QueueAsLinkedList ()
	{ list = new LinkedList (); }

    public void purge ()
    {
	list.purge ();
	count = 0;
    }
    // ...
}
