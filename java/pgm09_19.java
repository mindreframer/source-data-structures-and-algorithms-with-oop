//
//   This file contains the Java code from Program 9.19 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm09_19.txt
//
public class NaryTree
    extends AbstractTree
{
    protected Object key;
    protected int degree;
    protected NaryTree[] subtree;

    public Tree getSubtree (int i)
    {
	if (isEmpty ())
	    throw new InvalidOperationException ();
	return subtree [i];
    }

    public void attachSubtree (int i, NaryTree t)
    {
	if (isEmpty () || !subtree [i].isEmpty ())
	    throw new InvalidOperationException ();
	subtree [i] = t;
    }

    NaryTree detachSubtree (int i)
    {
	if (isEmpty ())
	    throw new InvalidOperationException ();
	NaryTree result = subtree [i];
	subtree [i] = new NaryTree (degree);
	return result;
    }
    // ...
}
