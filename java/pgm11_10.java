//
//   This file contains the Java code from Program 11.10 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm11_10.txt
//
public class LeftistHeap
    extends BinaryTree
    implements MergeablePriorityQueue
{
    protected int nullPathLength;

    public void enqueue (Comparable object)
	{ merge (new LeftistHeap (object)); }
    // ...
}
