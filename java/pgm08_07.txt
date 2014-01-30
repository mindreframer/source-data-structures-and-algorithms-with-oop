//
//   This file contains the Java code from Program 8.7 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm08_07.txt
//
public abstract class AbstractHashTable
    extends AbstractSearchableContainer
    implements HashTable
{
    public abstract int getLength ();

    protected final int f (Object object)
	{ return object.hashCode (); }

    protected final int g (int x)
	{ return Math.abs (x) % getLength (); }

    protected final int h (Object object)
	{ return g(f(object)); }
    // ...
}
