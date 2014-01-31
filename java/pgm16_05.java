//
//   This file contains the Java code from Program 16.5 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm16_05.txt
//
public abstract class AbstractGraph
    extends AbstractContainer
    implements Graph
{
    protected int numberOfVertices;
    protected int numberOfEdges;
    protected Vertex[] vertex;

    public AbstractGraph (int size)
	{ vertex = new Vertex [size]; }

    protected final class GraphVertex
	extends AbstractObject
	implements Vertex
    {
	protected int number;
	protected Object weight;
	// ...
    }

    protected final class GraphEdge 
	extends AbstractObject
	implements Edge
    {
	protected int v0;
	protected int v1;
	protected Object weight;
	// ...
    }

    protected abstract Enumeration getIncidentEdges (int v);
    protected abstract Enumeration getEmanatingEdges (int v);
    // ...
}
