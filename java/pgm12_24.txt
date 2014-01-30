//
//   This file contains the Java code from Program 12.24 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm12_24.txt
//
public class PartitionAsForestV3
    extends PartitionAsForestV2
{
    public void join (Set s, Set t)
    {
	PartitionTree p = (PartitionTree) s;
	PartitionTree q = (PartitionTree) t;
	checkArguments (p, q);
	if (p.rank > q.rank)
	    q.parent = p;
	else
	{
	    p.parent = q;
	    if (p.rank == q.rank)
		q.rank += 1;
	}
	--count;
    }
    // ...
}
