//
//   This file contains the Java code from Program 16.13 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm16_13.txt
//
public abstract class AbstractGraph
    extends AbstractContainer
    implements Graph
{
    protected int numberOfVertices;
    protected int numberOfEdges;
    protected Vertex[] vertex;

    public boolean isCyclic ()
    {
	final Counter counter = new Counter ();
	Visitor visitor = new AbstractVisitor ()
	{
	    public void visit (Object object)
		{ ++counter.value; }
	};
	topologicalOrderTraversal (visitor);
	return counter.value != numberOfVertices;
    }
    // ...
}
