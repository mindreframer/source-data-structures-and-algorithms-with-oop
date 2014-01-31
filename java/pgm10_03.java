//
//   This file contains the Java code from Program 10.3 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm10_03.txt
//
public class BinarySearchTree
    extends BinaryTree
    implements SearchTree
{
    private BinarySearchTree getLeftBST ()
	{ return (BinarySearchTree) getLeft (); }
    
    private BinarySearchTree getRightBST ()
	{ return (BinarySearchTree) getRight (); }
    // ...
}
