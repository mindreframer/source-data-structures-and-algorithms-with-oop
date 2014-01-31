//
//   This file contains the Java code from Program 11.16 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm11_16.txt
//
public class BinomialQueue
    extends AbstractContainer
    implements MergeablePriorityQueue
{
    protected LinkedList treeList;

    protected void addTree (BinomialTree tree)
    {
	treeList.append (tree);
	count += tree.getCount ();
    }

    protected void removeTree (BinomialTree tree)
    {
	treeList.extract (tree);
	count -= tree.getCount ();
    }
    // ...
}
