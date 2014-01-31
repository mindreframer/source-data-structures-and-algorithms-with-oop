//
//   This file contains the Java code from Program 10.5 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm10_05.txt
//
public class BinarySearchTree
    extends BinaryTree
    implements SearchTree
{
    public void insert (Comparable object)
    {
	if (isEmpty ())
	    attachKey (object);
	else
	{
	    int diff = object.compare ((Comparable) getKey ());
	    if (diff == 0)
		throw new IllegalArgumentException (
		    "duplicate key");
	    if (diff < 0)
		getLeftBST ().insert (object);
	    else
		getRightBST ().insert (object);
	}
	balance ();
    }

    public void attachKey (Object object)
    {
	if (!isEmpty ())
	    throw new InvalidOperationException ();
	key = object;
	left = new BinarySearchTree ();
	right = new BinarySearchTree ();
    }

    protected void balance ()
	{}
    // ...
}
