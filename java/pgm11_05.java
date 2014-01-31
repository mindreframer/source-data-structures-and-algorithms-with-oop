//
//   This file contains the Java code from Program 11.5 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm11_05.txt
//
public class BinaryHeap
    extends AbstractContainer
    implements PriorityQueue
{
    protected Comparable[] array;

    public void enqueue (Comparable object)
    {
	if (count == array.length - 1)
	    throw new ContainerFullException ();
	++count;
	int i = count;
	while (i > 1 && array [i/2].isGT (object))
	{
	    array [i] = array [i / 2];
	    i /= 2;
	}
	array [i] = object;
    }
    // ...
}
