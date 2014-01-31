//
//   This file contains the Java code from Program 5.6 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm05_06.txt
//
public class Dbl
    extends AbstractObject
{
    protected double value;

    public Dbl (double value)
	{ this.value = value; }

    public double doubleValue ()
	{ return value; }

    protected int compareTo (Comparable object)
    {
	Dbl arg = (Dbl) object;
	if (value < arg.value)
	    return -1;
	else if (value > arg.value)
	    return +1;
	else
	    return 0;
    }
    // ...
}
