//
//   This file contains the Java code from Program 11.17 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm11_17.txt
//
public class BinomialQueue
    extends AbstractContainer
    implements MergeablePriorityQueue
{
    protected LinkedList treeList;

    protected BinomialTree findMinTree ()
    {
	BinomialTree minTree = null;
	for (LinkedList.Element ptr = treeList.getHead ();
	    ptr != null; ptr = ptr.getNext ())
	{
	    BinomialTree tree = (BinomialTree) ptr.getDatum ();
	    if (minTree == null ||
		    ((Comparable) tree.getKey ()).isLT (
		    ((Comparable) minTree.getKey ())) )
		minTree = tree;
	}
	return minTree;
    }

    public Comparable findMin ()
    {
	if (count == 0)
	    throw new ContainerEmptyException ();
	return (Comparable) findMinTree ().getKey ();
    }
    // ...
}
