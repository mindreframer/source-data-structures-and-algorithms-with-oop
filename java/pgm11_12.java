//
//   This file contains the Java code from Program 11.12 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm11_12.txt
//
public class LeftistHeap
    extends BinaryTree
    implements MergeablePriorityQueue
{
    protected int nullPathLength;

    public Comparable dequeueMin ()
    {
	if (isEmpty ())
	    throw new ContainerEmptyException ();

	Comparable result = (Comparable) getKey ();
	LeftistHeap oldLeft = getLeftHeap ();
	LeftistHeap oldRight = getRightHeap ();

	purge ();
	swapContents (oldLeft);
	merge (oldRight);

	return result;
    }
    // ...
}
