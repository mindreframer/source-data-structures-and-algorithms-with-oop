//
//   This file contains the Java code from Program 14.4 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm14_04.txt
//
public class DepthFirstSolver
    extends AbstractSolver
{
    protected void search (Solution solution)
    {
	if (solution.isComplete ())
	    updateBest (solution);
	else
	{
	    Enumeration i = solution.getSuccessors ();
	    while (i.hasMoreElements ())
	    {
		Solution successor = (Solution) i.nextElement ();
		search (successor);
	    }
	}
    }
}
