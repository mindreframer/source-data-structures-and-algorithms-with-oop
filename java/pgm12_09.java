//
//   This file contains the Java code from Program 12.9 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm12_09.txt
//
public class SetAsBitVector
    extends AbstractSet
    implements Set
{
    protected int[] vector;

    public Set union (Set set)
    {
	SetAsBitVector arg = (SetAsBitVector) set;
	if (universeSize != arg.universeSize)
	    throw new IllegalArgumentException (
		"mismatched sets");
	SetAsBitVector result = new SetAsBitVector(universeSize);
	for (int i = 0; i < vector.length; ++i)
	    result.vector [i] = vector [i] | arg.vector [i];
	return result;
    }

    public Set intersection (Set set)
    {
	SetAsBitVector arg = (SetAsBitVector) set;
	if (universeSize != arg.universeSize)
	    throw new IllegalArgumentException (
		"mismatched sets");
	SetAsBitVector result = new SetAsBitVector(universeSize);
	for (int i = 0; i < vector.length; ++i)
	    result.vector [i] = vector [i] & arg.vector [i];
	return result;
    }

    public Set difference (Set set)
    {
	SetAsBitVector arg = (SetAsBitVector) set;
	if (universeSize != arg.universeSize)
	    throw new IllegalArgumentException (
		"mismatched sets");
	SetAsBitVector result = new SetAsBitVector(universeSize);
	for (int i = 0; i < vector.length; ++i)
	    result.vector [i] = vector [i] & ~arg.vector [i];
	return result;
    }
    // ...
}
