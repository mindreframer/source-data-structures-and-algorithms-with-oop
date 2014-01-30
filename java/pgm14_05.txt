//
//   This file contains the Java code from Program 14.5 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm14_05.txt
//
public class BreadthFirstSolver
    extends AbstractSolver
{
    protected void search (Solution initial)
    {
	Queue queue = new QueueAsLinkedList ();
	queue.enqueue (initial);
	while (!queue.isEmpty ())
	{
	    Solution solution = (Solution) queue.dequeue ();
	    if (solution.isComplete ())
		updateBest (solution);
	    else
	    {
		Enumeration i = solution.getSuccessors ();
		while (i.hasMoreElements ())
		{
		    Solution successor =
			(Solution) i.nextElement ();
		    queue.enqueue (successor);
		}
	    }
	}
    }
}
