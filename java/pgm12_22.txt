//
//   This file contains the Java code from Program 12.22 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm12_22.txt
//
public class PartitionAsForestV2
    extends PartitionAsForest
{
    public Set find (int item)
    {
	PartitionTree root = array [item];
	while (root.parent != null)
	    root = root.parent;
	PartitionTree ptr = array [item];
	while (ptr.parent != null)
	{
	    PartitionTree tmp = ptr.parent;
	    ptr.parent = root;
	    ptr = tmp;
	}
	return root;
    }
    // ...
}
