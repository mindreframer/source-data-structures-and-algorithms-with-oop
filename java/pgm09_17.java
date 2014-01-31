//
//   This file contains the Java code from Program 9.17 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm09_17.txt
//
public class NaryTree
    extends AbstractTree
{
    protected Object key;
    protected int degree;
    protected NaryTree[] subtree;

    public NaryTree (int degree)
    {
	key = null;
	this.degree = degree;
	subtree = null;
    }

    public NaryTree (int degree, Object key)
    {
	this.key = key;
	this.degree = degree;
	subtree = new NaryTree[degree];
	for (int i = 0; i < degree; ++i)
	    subtree [i] = new NaryTree (degree);
    }
    // ...
}
