//
//   This file contains the Java code from Program 8.12 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm08_12.txt
//
public abstract class AbstractHashTable
    extends AbstractSearchableContainer
    implements HashTable
{
    public abstract int getLength ();

    public final double getLoadFactor ()
	{ return (double) getCount () / getLength (); }
    // ...
}
