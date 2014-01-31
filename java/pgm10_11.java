//
//   This file contains the Java code from Program 10.11 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm10_11.txt
//
public class AVLTree
    extends BinarySearchTree
{
    protected int height;

    protected void balance ()
    {
	adjustHeight ();
	if (getBalanceFactor () > 1)
	{
	    if (getLeftAVL ().getBalanceFactor () > 0)
		doLLRotation ();
	    else
		doLRRotation ();
	}
	else if (getBalanceFactor () < -1)
	{
	    if (getRightAVL ().getBalanceFactor () < 0)
		doRRRotation ();
	    else
		doRLRotation ();
	}
    }
    // ...
}
