//
//   This file contains the Java code from Program 16.10 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm16_10.txt
//
public abstract class AbstractGraph
    extends AbstractContainer
    implements Graph
{
    protected int numberOfVertices;
    protected int numberOfEdges;
    protected Vertex[] vertex;

    public void topologicalOrderTraversal (Visitor visitor)
    {
	int[] inDegree = new int [numberOfVertices];
	for (int v = 0; v < numberOfVertices; ++v)
	    inDegree [v] = 0;
	Enumeration p = getEdges ();
	while (p.hasMoreElements ())
	{
	    Edge edge = (Edge) p.nextElement ();
	    Vertex to = edge.getV1 ();
	    ++inDegree [to.getNumber ()];
	}

	Queue queue = new QueueAsLinkedList ();
	for (int v = 0; v < numberOfVertices; ++v)
	    if (inDegree [v] == 0)
		queue.enqueue (vertex [v]);
	while (!queue.isEmpty () && !visitor.isDone ())
	{
	    Vertex v = (Vertex) queue.dequeue ();
	    visitor.visit (v);
	    Enumeration q = v.getSuccessors ();
	    while (q.hasMoreElements ())
	    {
		Vertex to = (Vertex) q.nextElement ();
		if (--inDegree [to.getNumber ()] == 0)
		    queue.enqueue (to);
	    }
	}
    }
    // ...
}
