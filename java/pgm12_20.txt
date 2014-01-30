//
//   This file contains the Java code from Program 12.20 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm12_20.txt
//
public class PartitionAsForest
    extends AbstractSet
    implements Partition
{
    protected PartitionTree[] array;

    public Set find (int item)
    {
	PartitionTree ptr = array [item];
	while (ptr.parent != null)
	    ptr = ptr.parent;
	return ptr;
    }
    // ...
}
