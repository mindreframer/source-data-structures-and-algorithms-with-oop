//
//   This file contains the Java code from Program 5.3 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm05_03.txt
//
public abstract class AbstractObject
    implements Comparable
{
    protected abstract int compareTo (Comparable arg);

    public final int compare (Comparable arg)
    {
	if (getClass () == arg.getClass ())
	    return compareTo (arg);
	else
	    return getClass ().getName ().compareTo (
		arg.getClass ().getName ());
    }
    // ...
}
