//
//   This file contains the Java code from Program 4.6 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm04_06.txt
//
public class Array
{
    protected Object[] data;
    protected int base;

    public void setBase (int base)
	{ this.base = base; }

    public void setLength (int newLength)
    {
	if (data.length != newLength)
	{
	    Object[] newData = new Object[newLength];
	    int min = data.length < newLength ?
		data.length : newLength;
	    for (int i = 0; i < min; ++i)
		newData [i] = data [i];
	    data = newData;
	}
    }
    // ...
}
