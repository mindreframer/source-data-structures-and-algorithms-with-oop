//
//   This file contains the Java code from Program 6.16 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm06_16.txt
//
public class QueueAsArray
    extends AbstractContainer
    implements Queue
{
    protected Object[] array;
    protected int head;
    protected int tail;

    public Object getHead ()
    {
	if (count == 0)
	    throw new ContainerEmptyException ();
	return array [head];
    }

    public void enqueue (Object object)
    {
	if (count == array.length)
	    throw new ContainerFullException ();
	if (++tail == array.length)
	    tail = 0;
	array [tail] = object;
	++count;
    }

    public Object dequeue ()
    {
	if (count == 0)
	    throw new ContainerEmptyException ();
	Object result = array [head];
	array [head] = null;
	if (++head == array.length)
	    head = 0;
	--count;
	return result;
    }
    // ...
}
