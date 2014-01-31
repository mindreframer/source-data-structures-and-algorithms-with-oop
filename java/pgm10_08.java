//
//   This file contains the Java code from Program 10.8 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm10_08.txt
//
public class AVLTree
    extends BinarySearchTree
{
    protected int height;

    public AVLTree ()
	{ height = -1; }

    public int getHeight ()
	{ return height; }

    protected void adjustHeight ()
    {
	if (isEmpty ())
	    height = -1;
	else
	    height = 1 + Math.max (
		left.getHeight (), right.getHeight ());
    }

    protected int getBalanceFactor ()
    {
	if (isEmpty ())
	    return 0;
	else
	    return left.getHeight () - right.getHeight ();
    }
    // ...
}
