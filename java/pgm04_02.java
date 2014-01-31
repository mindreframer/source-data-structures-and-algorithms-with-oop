//
//   This file contains the Java code from Program 4.2 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm04_02.txt
//
public class Array
{
    protected Object[] data;
    protected int base;

    public Array (int n, int m)
    {
	data = new Object[n];
	base = m;
    }

    public Array ()
	{ this (0, 0); }

    public Array (int n)
	{ this (n, 0); }
    // ...
}
