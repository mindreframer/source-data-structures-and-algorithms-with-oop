//
//   This file contains the Java code from Program A.6 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm0A_06.txt
//
public class Complex
{
    private double real;
    private double imag;

    public void setR (double r)
    {
	double theta = getTheta ();
	real = r * Math.cos (theta);
	imag = r * Math.sin (theta);
    }

    public void setTheta (double theta)
    {
	double r = getR ();
	real = r * Math.cos (theta);
	imag = r * Math.sin (theta);
    }

    public void assign (Complex c)
    {
	real = c.real;
	imag = c.imag;
    }
    // ...
}
