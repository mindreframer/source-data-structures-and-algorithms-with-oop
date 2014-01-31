//
//   This file contains the Java code from Program 16.19 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm16_19.txt
//
public class Algorithms
{
    private static final class EarliestTimeVisitor
	extends AbstractVisitor
    {
	int[] earliestTime;

	EarliestTimeVisitor (int[] earliestTime)
	    { this.earliestTime = earliestTime; }

	public void visit (Object object)
	{
	    Vertex w = (Vertex) object;
	    int max = earliestTime [0];
	    Enumeration p = w.getIncidentEdges ();
	    while (p.hasMoreElements ())
	    {
		Edge edge = (Edge) p.nextElement ();
		Vertex v = edge.getV0();
		Int wt = (Int) edge.getWeight ();
		max = Math.max (max,
		    earliestTime[v.getNumber()] + wt.intValue());
	    }
	    earliestTime [w.getNumber ()] = max;
	}
    }
}
