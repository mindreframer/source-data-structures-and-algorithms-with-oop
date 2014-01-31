//
//   This file contains the Java code from Program 16.9 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm16_09.txt
//
public abstract class AbstractGraph
    extends AbstractContainer
    implements Graph
{
    protected int numberOfVertices;
    protected int numberOfEdges;
    protected Vertex[] vertex;

    public void breadthFirstTraversal (
	Visitor visitor, int start)
    {
	boolean[] enqueued = new boolean [numberOfVertices];
	for (int v = 0; v < numberOfVertices; ++v)
	    enqueued [v] = false;

	Queue queue = new QueueAsLinkedList ();

	enqueued [start] = true;
	queue.enqueue (vertex [start]);
	while (!queue.isEmpty () && !visitor.isDone ())
	{
	    Vertex v = (Vertex) queue.dequeue ();
	    visitor.visit (v);
	    Enumeration p = v.getSuccessors ();
	    while (p.hasMoreElements ())
	    {
		Vertex to = (Vertex) p.nextElement ();
		if (!enqueued [to.getNumber ()])
		{
		    enqueued [to.getNumber ()] = true;
		    queue.enqueue (to);
		}
	    }
	}
    }
    // ...
}
