//
//   This file contains the Java code from Program 12.19 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm12_19.txt
//
public class PartitionAsForest
    extends AbstractSet
    implements Partition
{
    protected PartitionTree[] array;

    public PartitionAsForest (int n)
    {
	super (n);
	array = new PartitionTree [universeSize];
	for (int item = 0; item < universeSize; ++item)
	    array [item] = new PartitionTree (item);
	count = universeSize;
    }
    // ...
}
