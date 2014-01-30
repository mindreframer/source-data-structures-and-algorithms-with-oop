//
//   This file contains the Java code from Program 8.10 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm08_10.txt
//
public class ChainedHashTable
    extends AbstractHashTable
{
    protected LinkedList[] array;

    public void insert (Comparable object)
    {
	array [h (object)].append (object);
	++count;
    }

    public void withdraw (Comparable object)
    {
	array [h (object)].extract (object);
	--count;
    }
    // ...
}
