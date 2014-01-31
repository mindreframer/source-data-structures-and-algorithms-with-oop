//
//   This file contains the Java code from Program 12.13 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm12_13.txt
//
public class MultisetAsArray
    extends AbstractSet
    implements Multiset
{
    protected int[] array;

    public Multiset union (Multiset set)
    {
	MultisetAsArray arg = (MultisetAsArray) set;
	if (universeSize != arg.universeSize)
	    throw new IllegalArgumentException (
		"mismatched sets");
	MultisetAsArray result =
	    new MultisetAsArray (universeSize);
	for (int i = 0; i < universeSize; ++i)
	    result.array [i] = array [i] + arg.array [i];
	return result;
    }

    public Multiset intersection (Multiset set)
    {
	MultisetAsArray arg = (MultisetAsArray) set;
	if (universeSize != arg.universeSize)
	    throw new IllegalArgumentException (
		"mismatched sets");
	MultisetAsArray result =
	    new MultisetAsArray (universeSize);
	for (int i = 0; i < universeSize; ++i)
	    result.array [i] = Math.min (
		array [i], arg.array [i]);
	return result;
    }

    public Multiset difference (Multiset set)
    {   MultisetAsArray arg = (MultisetAsArray) set;
	if (universeSize != arg.universeSize)
	    throw new IllegalArgumentException (
		"mismatched sets");
	MultisetAsArray result =
	    new MultisetAsArray (universeSize);
	for (int i = 0; i < universeSize; ++i)
	    if (arg.array [i] <= array [i])
		result.array [i] = array [i] - arg.array [i];
	return result;
    }
    // ...
}
