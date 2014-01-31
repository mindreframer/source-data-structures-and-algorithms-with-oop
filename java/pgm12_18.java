//
//   This file contains the Java code from Program 12.18 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm12_18.txt
//
public class PartitionAsForest
    extends AbstractSet
    implements Partition
{
    protected PartitionTree[] array;

    protected class PartitionTree
	extends AbstractSet
	implements Set, Tree
    {
	protected int item;
	protected PartitionTree parent;
	protected int rank;

	public PartitionTree (int item)
	{
	    super (PartitionAsForest.this.universeSize);
	    this.item = item;
	    parent = null;
	    rank = 0;
	    count = 1;
	}
	// ...
    }
    // ...
}
