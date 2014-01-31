//
//   This file contains the Java code from Program 16.12 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm16_12.txt
//
public abstract class AbstractGraph
    extends AbstractContainer
    implements Graph
{
    protected int numberOfVertices;
    protected int numberOfEdges;
    protected Vertex[] vertex;

    public boolean isStronglyConnected ()
    {
	final Counter counter = new Counter ();
	for (int v = 0; v < numberOfVertices; ++v)
	{
	    counter.value = 0;
	    PrePostVisitor visitor = new AbstractPrePostVisitor()
	    {
		public void visit (Object object)
		    { ++counter.value; }
	    };
	    depthFirstTraversal (visitor, v);
	    if (counter.value != numberOfVertices)
		return false;
	}
	return true;
    }
    // ...
}
