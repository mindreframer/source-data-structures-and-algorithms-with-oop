//
//   This file contains the Java code from Program 6.6 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm06_06.txt
//
public class StackAsArray
    extends AbstractContainer
    implements Stack
{
    protected Object[] array;

    public Enumeration getEnumeration ()
    {
	return new Enumeration ()
	{
	    protected int position = 0;

	    public boolean hasMoreElements ()
		{ return position < getCount (); }

	    public Object nextElement ()
	    {
		if (position >= getCount ())
		    throw new NoSuchElementException ();
		return array [position++];
	    }
	};
    }
    // ...
}
