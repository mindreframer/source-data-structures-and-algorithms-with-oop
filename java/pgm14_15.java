//
//   This file contains the Java code from Program 14.15 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm14_15.txt
//
public class SimpleRV
    implements RandomVariable
{
    public double nextDouble ()
	{ return RandomNumberGenerator.nextDouble (); }
}
