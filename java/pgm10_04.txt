//
//   This file contains the Java code from Program 10.4 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm10_04.txt
//
public class BinarySearchTree
    extends BinaryTree
    implements SearchTree
{
    public Comparable find (Comparable object)
    {
	if (isEmpty ())
	    return null;
	int diff = object.compare ((Comparable) getKey ());
	if (diff == 0)
	    return (Comparable) getKey ();
	else if (diff < 0)
	    return getLeftBST ().find (object);
	else
	    return getRightBST ().find (object);
    }

    public Comparable findMin ()
    {
	if (isEmpty ())
	    return null;
	else if (getLeftBST ().isEmpty ())
	    return (Comparable) getKey ();
	else
	    return getLeftBST ().findMin();
    }
    // ...
}
