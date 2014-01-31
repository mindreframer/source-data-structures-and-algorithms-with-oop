//
//   This file contains the Java code from Program 12.5 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm12_05.txt
//
public class SetAsArray
    extends AbstractSet
    implements Set
{
    protected boolean[] array;

    public Set union (Set set)
    {
	SetAsArray arg = (SetAsArray) set;
	if (universeSize != arg.universeSize)
	    throw new IllegalArgumentException (
		"mismatched sets");
	SetAsArray result = new SetAsArray (universeSize);
	for (int i = 0; i < universeSize; ++i)
	    result.array [i] = array [i] || arg.array [i];
	return result;
    }

    public Set intersection (Set set)
    {
	SetAsArray arg = (SetAsArray) set;
	if (universeSize != arg.universeSize)
	    throw new IllegalArgumentException (
		"mismatched sets");
	SetAsArray result = new SetAsArray (universeSize);
	for (int i = 0; i < universeSize; ++i)
	    result.array [i] = array [i] && arg.array [i];
	return result;
    }

    public Set difference (Set set)
    {
	SetAsArray arg = (SetAsArray) set;
	if (universeSize != arg.universeSize)
	    throw new IllegalArgumentException (
		"mismatched sets");
	SetAsArray result = new SetAsArray (universeSize);
	for (int i = 0; i < universeSize; ++i)
	    result.array [i] = array [i] && !arg.array [i];
	return result;
    }
    // ...
}
