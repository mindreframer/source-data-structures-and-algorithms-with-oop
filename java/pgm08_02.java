//
//   This file contains the Java code from Program 8.2 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm08_02.txt
//
public class Dbl
    extends AbstractObject
{
    protected double value;

    public int hashCode ()
    {
	long bits = Double.doubleToLongBits (value);
	return (int)(bits >>> 20);
    }
    // ...
}
