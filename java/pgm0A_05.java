//
//   This file contains the Java code from Program A.5 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm0A_05.txt
//
public class Complex
{
    private double real;
    private double imag;

    public double getReal ()
	{ return real; }

    public double getImag ()
	{ return imag; }

    public double getR ()
	{ return Math.sqrt (real * real + imag * imag); }

    public double getTheta ()
	{ return Math.atan2 (imag, real); }

    public String toString ()
	{ return real + "+" + imag + "i"; }
    // ...
}
