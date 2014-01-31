//
//   This file contains the Java code from Program 5.7 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm05_07.txt
//
public class Str
    extends AbstractObject
{
    protected String value;

    public Str (String value)
	{ this.value = value; }

    public String stringValue ()
	{ return value; }

    protected int compareTo (Comparable object)
    {
	Str arg = (Str) object;
	return value.compareTo (arg.value);
    }
    // ...
}
