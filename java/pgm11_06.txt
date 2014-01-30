//
//   This file contains the Java code from Program 11.6 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm11_06.txt
//
public class BinaryHeap
    extends AbstractContainer
    implements PriorityQueue
{
    protected Comparable[] array;

    public Comparable findMin ()
    {
	if (count == 0)
	    throw new ContainerEmptyException ();
	return array [1];
    }
    // ...
}
