//
//   This file contains the Java code from Program 11.14 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm11_14.txt
//
public class BinomialQueue
    extends AbstractContainer
    implements MergeablePriorityQueue
{
    protected LinkedList treeList;

    protected static class BinomialTree
	extends GeneralTree
    {
	protected void add (BinomialTree tree)
	{
	    if (degree != tree.degree)
		throw new IllegalArgumentException (
		    "incompatible degrees");
	    if ( ((Comparable) getKey ()).isGT (
		    ((Comparable) tree.getKey ())) )
		swapContents (tree);
	    attachSubtree (tree);
	}
    }
    // ...
}
