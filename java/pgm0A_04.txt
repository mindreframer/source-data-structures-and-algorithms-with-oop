//
//   This file contains the Java code from Program A.4 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm0A_04.txt
//
public class Complex
{
    private double real;
    private double imag;

    public Complex (double x, double y)
    {
	real = x;
	imag = y;
    }

    public Complex ()
	{ this (0, 0); }

    public Complex (double x)
	{ this (x, 0); }
    // ...
}
