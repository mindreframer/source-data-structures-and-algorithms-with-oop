//
//   This file contains the Java code from Program 16.18 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm16_18.txt
//
public class Algorithms
{
    public static Graph KruskalsAlgorithm (Graph g)
    {
	int n = g.getNumberOfVertices ();

	Graph result = new GraphAsLists (n);
	for (int v = 0; v < n; ++v)
	    result.addVertex (v);

	PriorityQueue queue =
	    new BinaryHeap (g.getNumberOfEdges());
	Enumeration p = g.getEdges ();
	while (p.hasMoreElements ())
	{
	    Edge edge = (Edge) p.nextElement ();
	    Int weight = (Int) edge.getWeight ();
	    queue.enqueue (new Association (weight, edge));
	}

	Partition partition = new PartitionAsForest (n);
	while (!queue.isEmpty () && partition.getCount () > 1)
	{
	    Association assoc = (Association) queue.dequeueMin();
	    Edge edge = (Edge) assoc.getValue ();
	    int n0 = edge.getV0 ().getNumber ();
	    int n1 = edge.getV1 ().getNumber ();
	    Set s = partition.find (n0);
	    Set t = partition.find (n1);
	    if (s != t)
	    {
		partition.join (s, t);
		result.addEdge (n0, n1);
	    }
	}
	return result;
    }
}
