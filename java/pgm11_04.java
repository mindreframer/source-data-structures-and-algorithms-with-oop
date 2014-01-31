//
//   This file contains the Java code from Program 11.4 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm11_04.txt
//
public class BinaryHeap
    extends AbstractContainer
    implements PriorityQueue
{
    protected Comparable[] array;

    public BinaryHeap (int length)
	{ array = new Comparable[length + 1]; }

    public void purge ()
    {
	while (count > 0)
	    array [count--] = null;
    }
    // ...
}
