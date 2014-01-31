//
//   This file contains the Java code from Program 8.1 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm08_01.txt
//
public class Int
    extends AbstractObject
{
    protected int value;

    public int hashCode ()
	{ return value; }
    // ...
}
