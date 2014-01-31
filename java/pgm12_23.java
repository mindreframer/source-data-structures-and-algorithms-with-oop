//
//   This file contains the Java code from Program 12.23 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm12_23.txt
//
public class PartitionAsForestV2
    extends PartitionAsForest
{
    public void join (Set s, Set t)
    {
	PartitionTree p = (PartitionTree) s;
	PartitionTree q = (PartitionTree) t;
	checkArguments (p, q);
	if (p.getCount () > q.getCount ())
	{
	    q.parent = p;
	    p.setCount (p.getCount () + q.getCount ());
	}
	else
	{
	    p.parent = q;
	    q.setCount (p.getCount () + q.getCount ());
	}
	--count;
    }
    // ...
}
