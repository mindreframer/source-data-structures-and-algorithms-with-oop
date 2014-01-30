//
//   This file contains the Java code from Program 6.24 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm06_24.txt
//
public class DequeAsLinkedList
    extends QueueAsLinkedList
    implements Deque
{
    public void enqueueHead (Object object)
    {
	list.prepend (object);
	++count;
    }

    public Object dequeueHead ()
	{ return dequeue (); }
    // ...
}
