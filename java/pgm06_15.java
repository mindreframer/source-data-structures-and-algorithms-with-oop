//
//   This file contains the Java code from Program 6.15 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm06_15.txt
//
public class QueueAsArray
    extends AbstractContainer
    implements Queue
{
    protected Object[] array;
    protected int head;
    protected int tail;

    public QueueAsArray (int size)
    {
	array = new Object [size];
	head = 0;
	tail = size - 1;
    }

    public void purge ()
    {
	while (count > 0)
	{
	    array [head] = null;
	    if (++head == array.length)
		head = 0;
	    --count;
	}
    }
    // ...
}
