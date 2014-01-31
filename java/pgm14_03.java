//
//   This file contains the Java code from Program 14.3 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm14_03.txt
//
public abstract class AbstractSolver
    implements Solver
{
    protected Solution bestSolution;
    protected int bestObjective;

    protected abstract void search (Solution initial);

    public Solution solve (Solution initial)
    {
	bestSolution = null;
	bestObjective = Integer.MAX_VALUE;
	search (initial);
	return bestSolution;
    }

    public void updateBest (Solution solution)
    {
	if (solution.isComplete () && solution.isFeasible ()
	    && solution.getObjective () < bestObjective)
	{
	    bestSolution = solution;
	    bestObjective = solution.getObjective ();
	}
    }
}
