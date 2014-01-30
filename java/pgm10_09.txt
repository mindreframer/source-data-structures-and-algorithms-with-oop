//
//   This file contains the Java code from Program 10.9 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm10_09.txt
//
public class AVLTree
    extends BinarySearchTree
{
    protected int height;

    protected void doLLRotation ()
    {
	if (isEmpty ())
	    throw new InvalidOperationException ();
	BinaryTree tmp = right;
	right = left;
	left = right.left;
	right.left = right.right;
	right.right = tmp;

	Object tmpObj = key;
	key = right.key;
	right.key = tmpObj;

	getRightAVL ().adjustHeight ();
	adjustHeight ();
    }
    // ...
}
