//
//   This file contains the Java code from Program 6.22 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm06_22.txt
//
public class DequeAsArray
    extends QueueAsArray
    implements Deque
{
    public void enqueueHead (Object object)
    {
	if (count == array.length)
	    throw new ContainerFullException ();
	if (head-- == 0)
	    head = array.length - 1;
	array [head] = object;
	++count;
    }

    public Object dequeueHead ()
	{ return dequeue (); }
    // ...
}
