//
//   This file contains the Java code from Program 5.4 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm05_04.txt
//
public class Chr
    extends AbstractObject
{
    protected char value;

    public Chr (char value)
	{ this.value = value; }

    public char charValue ()
	{ return value; }

    protected int compareTo (Comparable object)
    {
	Chr arg = (Chr) object;
	return (int) value - (int) arg.value;
    }
    // ...
}
