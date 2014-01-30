//
//   This file contains the Java code from Program 16.16 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm16_16.txt
//
public class Algorithms
{
    public static Digraph FloydsAlgorithm (Digraph g)
    {
	int n = g.getNumberOfVertices ();
	int[][] distance = new int[n][n];
	for (int v = 0; v < n; ++v)
	    for (int w = 0; w < n; ++w)
		distance [v][w] = Integer.MAX_VALUE;

	Enumeration p = g.getEdges ();
	while (p.hasMoreElements ())
	{
	    Edge edge = (Edge) p.nextElement ();
	    Int wt = (Int) edge.getWeight ();
	    distance [edge.getV0().getNumber()]
		[edge.getV1().getNumber()] = wt.intValue ();
	}

	for (int i = 0; i < n; ++i)
	    for (int v = 0; v < n; ++v)
		for (int w = 0; w < n; ++w)
		    if (distance [v][i] != Integer.MAX_VALUE &&
			distance [i][w] != Integer.MAX_VALUE)
		    {
			int d = distance[v][i] + distance[i][w];
			if (distance [v][w] > d)
			    distance [v][w] = d;
		    }

	Digraph result = new DigraphAsMatrix (n);
	for (int v = 0; v < n; ++v)
	    result.addVertex (v);
	for (int v = 0; v < n; ++v)
	    for (int w = 0; w < n; ++w)
		if (distance [v][w] != Integer.MAX_VALUE)
		    result.addEdge (v, w,
			new Int (distance [v][w]));
	return result;
    }
}
