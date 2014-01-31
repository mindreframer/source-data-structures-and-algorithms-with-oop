//
//   This file contains the Java code from Program 9.24 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm09_24.txt
//
public class BinaryTree
    extends AbstractTree
{
    protected Object key;
    protected BinaryTree left;
    protected BinaryTree right;

    protected int compareTo (Comparable object)
    {
	BinaryTree arg = (BinaryTree) object;
	if (isEmpty ())
	    return arg.isEmpty () ? 0 : -1;
	else if (arg.isEmpty ())
	    return 1;
	else
	{
	    int result = ((Comparable) getKey ()).compare (
		(Comparable) arg.getKey ());
	    if (result == 0)
		result = getLeft ().compareTo (arg.getLeft ());
	    if (result == 0)
		result = getRight ().compareTo (arg.getRight ());
	    return result;
	}
    }
    // ...
}
