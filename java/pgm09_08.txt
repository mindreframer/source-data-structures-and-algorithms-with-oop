//
//   This file contains the Java code from Program 9.8 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm09_08.txt
//
public abstract class AbstractTree
    extends AbstractContainer
    implements Tree
{
    public void breadthFirstTraversal (Visitor visitor)
    {
	Queue queue = new QueueAsLinkedList ();
	if (!isEmpty ())
	    queue.enqueue (this);
	while (!queue.isEmpty () && !visitor.isDone ())
	{
	    Tree head = (Tree) queue.dequeue ();
	    visitor.visit (head.getKey ());
	    for (int i = 0; i < head.getDegree (); ++i)
	    {
		Tree child = head.getSubtree (i);
		if (!child.isEmpty ())
		    queue.enqueue (child);
	    }
	}
    }
    // ...
}
