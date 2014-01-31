//
//   This file contains the Java code from Program 11.20 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm11_20.txt
//
public class BinomialQueue
    extends AbstractContainer
    implements MergeablePriorityQueue
{
    protected LinkedList treeList;

    public void enqueue (Comparable object)
    {
	BinomialQueue queue = new BinomialQueue ();
	queue.addTree (new BinomialTree (object));
	merge (queue);
    }
    // ...
}
