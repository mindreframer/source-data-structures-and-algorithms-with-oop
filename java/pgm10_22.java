//
//   This file contains the Java code from Program 10.22 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm10_22.txt
//
public class BTree
    extends MWayTree
{
    protected BTree parent;

    protected void insertPair (Comparable object, BTree child)
    {
	int index = findIndex (object);
	if (!isFull ())
	{
	    insertKey (index + 1, object);
	    insertSubtree (index + 1, child);
	    ++count;
	}
	else
	{
	    Comparable extraKey = insertKey (index + 1, object);
	    BTree extraTree = insertSubtree (index + 1, child);
	    if (parent == null)
	    {
		BTree left = new BTree (getM ());
		BTree right = new BTree (getM ());
		left.attachLeftHalfOf (this);
		right.attachRightHalfOf (this);
		right.insertPair (extraKey, extraTree);
		attachSubtree (0, left);
		key [1] = key [(getM () + 1)/2];
		attachSubtree (1, right);
		count = 1;
	    }
	    else
	    {
		count = (getM () + 1)/2 - 1;
		BTree right = new BTree (getM ());
		right.attachRightHalfOf (this);
		right.insertPair (extraKey, extraTree);
		parent.insertPair (key [(getM () + 1)/2], right);
	    }
	}
    }
    // ...
}
