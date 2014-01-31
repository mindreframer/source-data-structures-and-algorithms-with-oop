//
//   This file contains the Java code from Program 9.18 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm09_18.txt
//
public class NaryTree
    extends AbstractTree
{
    protected Object key;
    protected int degree;
    protected NaryTree[] subtree;

    public boolean isEmpty ()
	{ return key == null; }

    public Object getKey ()
    {
	if (isEmpty ())
	    throw new InvalidOperationException ();
	return key;
    }

    public void attachKey (Object object)
    {
	if (!isEmpty ())
	    throw new InvalidOperationException ();
	key = object;
	subtree = new NaryTree[degree];
	for (int i = 0; i < degree; ++i)
	    subtree [i] = new NaryTree (degree);
    }

    public Object detachKey ()
    {
	if (!isLeaf ())
	    throw new InvalidOperationException ();
	Object result = key;
	key = null;
	subtree = null;
	return result;
    }
    // ...
}
