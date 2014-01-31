//
//   This file contains the Java code from Program 4.5 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm04_05.txt
//
public class Array
{
    protected Object[] data;
    protected int base;

    public Object get (int position)
	{ return data [position - base]; }

    public void put (int position, Object object)
	{ data [position - base] = object; }
    // ...
}
