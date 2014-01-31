//
//   This file contains the Java code from Program 12.2 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm12_02.txt
//
public abstract class AbstractSet
    extends AbstractSearchableContainer
{
    protected int universeSize;

    public AbstractSet (int universeSize)
	{ this .universeSize = universeSize; }
    
    protected abstract void insert (int i);
    protected abstract void withdraw (int i);
    protected abstract boolean isMember (int i);

    public void insert (Comparable object)
	{ insert (((Int) object).intValue ()); }

    public void withdraw (Comparable object)
	{ withdraw (((Int) object).intValue ()); }

    public boolean isMember (Comparable object)
	{ return isMember (((Int) object).intValue ()); }
}
