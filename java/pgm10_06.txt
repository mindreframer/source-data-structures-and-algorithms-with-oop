//
//   This file contains the Java code from Program 10.6 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm10_06.txt
//
public class BinarySearchTree
    extends BinaryTree
    implements SearchTree
{
    public void withdraw (Comparable object)
    {
	if (isEmpty ())
	    throw new IllegalArgumentException (
		"object not found");
	int diff = object.compare ((Comparable) getKey ());
	if (diff == 0)
	{
	    if (!getLeftBST ().isEmpty ())
	    {
		Comparable max = getLeftBST ().findMax ();
		key = max;
		getLeftBST ().withdraw (max);
	    }
	    else if (!getRightBST ().isEmpty ())
	    {
		Comparable min = getRightBST ().findMin ();
		key = min;
		getRightBST ().withdraw (min);
	    }
	    else
		detachKey ();
	}
	else if (diff < 0)
	    getLeftBST ().withdraw (object);
	else
	    getRightBST ().withdraw (object);
	balance ();
    }
    // ...
}
