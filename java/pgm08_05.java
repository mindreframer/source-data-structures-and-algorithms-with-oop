//
//   This file contains the Java code from Program 8.5 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm08_05.txt
//
public class Association
    extends AbstractObject
{
    protected Comparable key;
    protected Object value;

    public int hashCode ()
	{ return key.hashCode (); }
    // ...
}
