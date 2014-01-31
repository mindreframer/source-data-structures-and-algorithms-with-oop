//
//   This file contains the Java code from Program 11.19 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm11_19.txt
//
public class BinomialQueue
    extends AbstractContainer
    implements MergeablePriorityQueue
{
    protected LinkedList treeList;

    protected BinomialTree sum (
	BinomialTree a, BinomialTree b, BinomialTree c)
    {
	if (a != null && b == null && c == null)
	    return a;
	else if (a == null && b != null && c == null)
	    return b;
	else if (a == null && b == null && c != null)
	    return c;
	else if (a != null && b != null && c != null)
	    return c;
	else
	    return null;
    }

    protected BinomialTree carry (
	BinomialTree a, BinomialTree b, BinomialTree c)
    {
	if (a != null && b != null && c == null)
	    { a.add (b); return a; }
	else if (a != null && b == null && c != null)
	    { a.add (c); return a; }
	else if (a == null && b != null && c != null)
	    { b.add (c); return b; }
	else if (a != null && b != null && c != null)
	    { a.add (b); return a; }
	else
	    return null;
    }
    // ...
}
