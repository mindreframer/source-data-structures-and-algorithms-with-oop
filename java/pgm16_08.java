//
//   This file contains the Java code from Program 16.8 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm16_08.txt
//
public abstract class AbstractGraph
    extends AbstractContainer
    implements Graph
{
    protected int numberOfVertices;
    protected int numberOfEdges;
    protected Vertex[] vertex;

    public void depthFirstTraversal (
	PrePostVisitor visitor, int start)
    {
	boolean[]  visited = new boolean [numberOfVertices];
	for (int v = 0; v < numberOfVertices; ++v)
	    visited [v] = false;
	depthFirstTraversal (visitor, vertex [start], visited);
    }

    private void depthFirstTraversal (
	PrePostVisitor visitor, Vertex v, boolean[] visited)
    {
	if (visitor.isDone ())
	    return;
	visitor.preVisit (v);
	visited [v.getNumber ()] = true;
	Enumeration p = v.getSuccessors ();
	while (p.hasMoreElements ())
	{
	    Vertex to = (Vertex) p.nextElement ();
	    if (!visited [to.getNumber ()])
		depthFirstTraversal (visitor, to, visited);
	}
	visitor.postVisit (v);
    }
    // ...
}
