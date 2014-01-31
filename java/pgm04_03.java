//
//   This file contains the Java code from Program 4.3 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm04_03.txt
//
public class Array
{
    protected Object[] data;
    protected int base;

    public void assign (Array array)
    {
	if (array != this)
	{
	    if (data.length != array.data.length)
		data = new Object [array.data.length];
	    for (int i = 0; i < data.length; ++i)
		data [i] = array.data [i];
	    base = array.base;
	}
    }
    // ...
}
