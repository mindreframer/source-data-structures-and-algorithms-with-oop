//
//   This file contains the Java code from Program 8.3 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm08_03.txt
//
public class Str
    extends AbstractObject
{
    protected String value;

    private static final int shift = 6;
    private static final int mask = ~0 << (32 - shift);

    public int hashCode ()
    {
	int result = 0;
	for (int i = 0; i < value.length (); ++i)
	    result = (result & mask) ^
		(result << shift) ^ value.charAt (i);
	return result;
    }
    // ...
}
