//
//   This file contains the Java code from Program 9.21 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm09_21.txt
//
public class BinaryTree
    extends AbstractTree
{
    protected Object key;
    protected BinaryTree left;
    protected BinaryTree right;

    public BinaryTree (
	Object key, BinaryTree left, BinaryTree right)
    {
	this.key = key;
	this.left = left;
	this.right = right;
    }

    public BinaryTree ()
	{ this (null, null, null); }

    public BinaryTree (Object key)
	{ this (key, new BinaryTree (), new BinaryTree ()); }
    // ...
}
