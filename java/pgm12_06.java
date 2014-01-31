//
//   This file contains the Java code from Program 12.6 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm12_06.txt
//
public class SetAsArray
    extends AbstractSet
    implements Set
{
    protected boolean[] array;

    public boolean isEQ (Set set)
    {
	SetAsArray arg = (SetAsArray) set;
	if (universeSize != arg.universeSize)
	    throw new IllegalArgumentException (
		"mismatched sets");
	for (int item = 0; item < universeSize; ++item)
	    if (array [item] != arg.array [item])
		return false;
	return true;
    }

    public boolean isSubset (Set set)
    {
	SetAsArray arg = (SetAsArray) set;
	if (universeSize != arg.universeSize)
	    throw new IllegalArgumentException (
		"mismatched sets");
	for (int item = 0; item < universeSize; ++item)
	    if (array [item] && !arg.array [item])
		return false;
	return true;
    }
    // ...
}
