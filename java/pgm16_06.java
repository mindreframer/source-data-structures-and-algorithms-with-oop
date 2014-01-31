//
//   This file contains the Java code from Program 16.6 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm16_06.txt
//
public class GraphAsMatrix
    extends AbstractGraph
{
    protected Edge[][] matrix;

    public GraphAsMatrix (int size)
    {
	super (size);
	matrix = new Edge [size][size];
    }
    // ...
}
