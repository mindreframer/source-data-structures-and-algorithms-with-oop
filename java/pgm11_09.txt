//
//   This file contains the Java code from Program 11.9 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm11_09.txt
//
public class LeftistHeap
    extends BinaryTree
    implements MergeablePriorityQueue
{
    protected int nullPathLength;

    public void merge (MergeablePriorityQueue queue)
    {
	LeftistHeap arg = (LeftistHeap) queue;
	if (isEmpty ())
	    swapContents (arg);
	else if (!arg.isEmpty ())
	{
	    if ( ((Comparable) getKey ()).isGT (
		    ((Comparable) arg.getKey ())) )
		swapContents (arg);
	    getRightHeap ().merge (arg);
	    if (getLeftHeap ().nullPathLength <
		    getRightHeap ().nullPathLength)
		swapSubtrees ();
	    nullPathLength = 1 + Math.min (
		getLeftHeap ().nullPathLength,
		getRightHeap ().nullPathLength);
	}
    }
    // ...
}
