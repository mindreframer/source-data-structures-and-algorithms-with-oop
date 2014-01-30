//
//   This file contains the Java code from Program 5.5 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm05_05.txt
//
public class Int
    extends AbstractObject
{
    protected int value;

    public Int (int value)
	{ this.value = value; }

    public int intValue ()
	{ return value; }

    protected int compareTo (Comparable object)
    {
	Int arg = (Int) object;
	long diff = (long) value - (long) arg.value;
	if (diff < 0)
	    return -1;
	else if (diff > 0)
	    return +1;
	else
	    return 0;
    }
    // ...
}
