//
//   This file contains the Java code from Program 16.11 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm16_11.txt
//
public abstract class AbstractGraph
    extends AbstractContainer
    implements Graph
{
    protected int numberOfVertices;
    protected int numberOfEdges;
    protected Vertex[] vertex;

    protected final static class Counter
    {
	int value = 0;
    }

    public boolean isConnected ()
    {
	final Counter counter = new Counter ();
	PrePostVisitor visitor = new AbstractPrePostVisitor ()
	{
	    public void visit (Object object)
		{ ++counter.value; }
	};
	depthFirstTraversal (visitor, 0);
	return counter.value == numberOfVertices;
    }
    // ...
}
