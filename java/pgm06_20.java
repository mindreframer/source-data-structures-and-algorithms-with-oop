//
//   This file contains the Java code from Program 6.20 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm06_20.txt
//
public class Algorithms
{
    public static void breadthFirstTraversal (Tree tree)
    {
	Queue queue = new QueueAsLinkedList ();
	if (!tree.isEmpty ())
	    queue.enqueue (tree);
	while (!queue.isEmpty ())
	{
	    Tree t = (Tree) queue.dequeue ();
	    System.out.println (t.getKey ());
	    for (int i = 0; i < t.getDegree (); ++i)
	    {
		Tree subTree = t.getSubtree (i);
		if (!subTree.isEmpty ())
		    queue.enqueue (subTree);
	    }
	}
    }
}
