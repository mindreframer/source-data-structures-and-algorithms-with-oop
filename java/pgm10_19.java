//
//   This file contains the Java code from Program 10.19 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm10_19.txt
//
public class MWayTree
    extends AbstractTree
    implements SearchTree
{
    protected Comparable key[];
    protected MWayTree subtree[];

    public void withdraw (Comparable object)
    {
	if (isEmpty ()) throw new IllegalArgumentException (
		"object not found");
	int index = findIndex (object);
	if (index != 0 && object.isEQ (key [index]))
	{
	    if (!subtree [index - 1].isEmpty ())
	    {
		Comparable max = subtree [index - 1].findMax ();
		key [index] = max;
		subtree [index - 1].withdraw (max);
	    }
	    else if (!subtree [index].isEmpty ())
	    {
		Comparable min = subtree [index].findMin ();
		key [index] = min;
		subtree [index].withdraw (min);
	    }
	    else
	    {
		--count;
		int i;
		for (i = index; i <= count; ++i)
		{   key [i] = key [i + 1];
		    subtree [i] = subtree [i + 1];
		}
		key [i] = null;
		subtree [i] = null;
		if (count == 0)
		    subtree [0] = null;
	    }
	}
	else
	    subtree [index].withdraw (object);
    }
    // ...
}
