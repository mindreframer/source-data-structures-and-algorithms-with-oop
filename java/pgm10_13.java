//
//   This file contains the Java code from Program 10.13 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm10_13.txt
//
public class AVLTree
    extends BinarySearchTree
{
    protected int height;

    public Object detachKey ()
    {
	height = -1;
	return super.detachKey ();
    }
    // ...
}
