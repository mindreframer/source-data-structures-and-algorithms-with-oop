//
//   This file contains the Java code from Program 10.12 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm10_12.txt
//
public class AVLTree
    extends BinarySearchTree
{
    protected int height;

    public void attachKey (Object object)
    {
	if (!isEmpty ())
	    throw new InvalidOperationException ();
	key = object;
	left = new AVLTree ();
	right = new AVLTree ();
	height = 0;
    }
    // ...
}
