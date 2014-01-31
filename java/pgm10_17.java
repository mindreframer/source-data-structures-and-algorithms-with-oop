//
//   This file contains the Java code from Program 10.17 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm10_17.txt
//
public class MWayTree
    extends AbstractTree
    implements SearchTree
{
    protected Comparable key[];
    protected MWayTree subtree[];

    protected int findIndex (Comparable object)
    {
	if (isEmpty () || object.isLT (key [1]))
	    return 0;
	int left = 1;
	int right = count;
	while (left < right)
	{
	    int middle = (left + right + 1) / 2;
	    if (object.isLT (key [middle]))
		right = middle - 1;
	    else
		left = middle;
	}
	return left;
    }

    public Comparable find (Comparable object)
    {
	if (isEmpty ())
	    return null;
	int index = findIndex (object);
	if (index != 0 && object.isEQ (key [index]))
	    return key [index];
	else
	    return subtree [index].find (object);
    }
    // ...
}
