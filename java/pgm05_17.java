//
//   This file contains the Java code from Program 5.17 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm05_17.txt
//
public class Association
    extends AbstractObject
{
    protected Comparable key;
    protected Object value;

    public Association (Comparable key, Object value)
    {
	this.key = key;
	this.value = value;
    }

    public Association (Comparable key)
	{ this (key, null); }

    public Comparable getKey ()
	{ return key; }

    public Object getValue ()
	{ return value; }
    // ...
}
