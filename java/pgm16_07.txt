//
//   This file contains the Java code from Program 16.7 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm16_07.txt
//
public class GraphAsLists
    extends AbstractGraph
{
    protected LinkedList[] adjacencyList;

    public GraphAsLists (int size)
    {
	super (size);
	adjacencyList = new LinkedList [size];
	for (int i = 0; i < size; ++i)
	    adjacencyList [i] = new LinkedList ();
    }
    // ...
}
