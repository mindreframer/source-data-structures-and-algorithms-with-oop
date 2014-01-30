//
//   This file contains the Java code from Program 6.25 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm06_25.txt
//
public class DequeAsLinkedList
    extends QueueAsLinkedList
    implements Deque
{
    public Object getTail ()
    {
	if (count == 0)
	    throw new ContainerEmptyException ();
	return list.getLast ();
    }

    public void enqueueTail (Object object)
	{ enqueue (object); }

    public Object dequeueTail ()
    {
	if (count == 0)
	    throw new ContainerEmptyException ();
	Object result = list.getLast ();
	list.extract (result);
	--count;
	return result;
    }
    // ...
}
