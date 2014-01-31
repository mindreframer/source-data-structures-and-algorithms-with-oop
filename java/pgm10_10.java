//
//   This file contains the Java code from Program 10.10 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm10_10.txt
//
public class AVLTree
    extends BinarySearchTree
{
    protected int height;

    protected void doLRRotation ()
    {
	if (isEmpty ())
	    throw new InvalidOperationException ();
	getLeftAVL ().doRRRotation ();
	doLLRotation ();
    }
    // ...
}
