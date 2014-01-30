//
//   This file contains the Java code from Program 5.2 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm05_02.txt
//
public abstract class AbstractObject
    implements Comparable
{
    public final boolean isLT (Comparable object)
	{ return compare (object) <  0; }

    public final boolean isLE (Comparable object)
	{ return compare (object) <= 0; }

    public final boolean isGT (Comparable object)
	{ return compare (object) >  0; }

    public final boolean isGE (Comparable object)
	{ return compare (object) >= 0; }

    public final boolean isEQ (Comparable object)
	{ return compare (object) == 0; }

    public final boolean isNE (Comparable object)
	{ return compare (object) != 0; }

    public final boolean equals (Object object)
    {
	if (object instanceof Comparable)
	    return isEQ ((Comparable) object);
	else
	    return false;
    }
    // ...
}
