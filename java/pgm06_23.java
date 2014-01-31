//
//   This file contains the Java code from Program 6.23 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm06_23.txt
//
public class DequeAsArray
    extends QueueAsArray
    implements Deque
{
    public Object getTail ()
    {
	if (count == 0)
	    throw new ContainerEmptyException ();
	return array [tail];
    }

    public void enqueueTail (Object object)
	{ enqueue (object); }

    public Object dequeueTail ()
    {
	if (count == 0)
	    throw new ContainerEmptyException ();
	Object result = array [tail];
	array [tail] = null;
	if (tail-- == 0)
	    tail = array.length - 1;
	--count;
	return result;
    }
    // ...
}
