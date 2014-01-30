//
//   This file contains the Java code from Program 12.21 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm12_21.txt
//
public class PartitionAsForest
    extends AbstractSet
    implements Partition
{
    protected PartitionTree[] array;

    protected void checkArguments (
	PartitionTree s, PartitionTree t)
    {
	if (!isMember (s) || s.parent != null ||
	    !isMember (t) || t.parent != null || s == t)
	    throw new IllegalArgumentException (
		"incompatible sets");
    }

    public void join (Set s, Set t)
    {
	PartitionTree p = (PartitionTree) s;
	PartitionTree q = (PartitionTree) t;
	checkArguments (p, q);
	q.parent = p;
	--count;
    }
    // ...
}
