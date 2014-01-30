//
//   This file contains the Java code from Program 10.20 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm10_20.txt
//
public class BTree
    extends MWayTree
{
    protected BTree parent;

    public BTree (int m)
	{ super (m); }

    public void attachSubtree (int i, MWayTree arg)
    {
	BTree btree = (BTree) arg;
	subtree [i] = btree;
	btree.parent = this;
    }
    // ...
}
