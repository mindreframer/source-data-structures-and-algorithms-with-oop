//
//   This file contains the Java code from Program 16.20 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm16_20.txt
//
public class Algorithms
{
    public static Digraph criticalPathAnalysis (Digraph g)
    {
	int n = g.getNumberOfVertices ();

	int[] earliestTime = new int [n];
	earliestTime [0] = 0;
	g.topologicalOrderTraversal (
	    new EarliestTimeVisitor (earliestTime));

	int[] latestTime = new int [n];
	latestTime [n - 1] = earliestTime [n - 1];
	g.depthFirstTraversal (new PostOrder (
	    new LatestTimeVisitor (latestTime)), 0);

	Digraph slackGraph = new DigraphAsLists (n);
	for (int v = 0; v < n; ++v)
	    slackGraph.addVertex (v);
	Enumeration p = g.getEdges ();
	while (p.hasMoreElements ())
	{
	    Edge edge = (Edge) p.nextElement ();
	    int n0 = edge.getV0().getNumber();
	    int n1 = edge.getV1().getNumber();
	    Int wt = (Int) edge.getWeight ();
	    int slack = latestTime [n1] - earliestTime [n0] -
		wt.intValue ();
	    slackGraph.addEdge (n0, n1, new Int (slack));
	}
	return DijkstrasAlgorithm (slackGraph, 0);
    }
}
