//
//   This file contains the Java code from Program 14.16 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm14_16.txt
//
public class UniformRV
    implements RandomVariable
{
    protected double u = 0.0;
    protected double v = 1.0;

    public UniformRV (double u, double v)
    {
	this.u = u;
	this.v = v;
    }

    public double nextDouble ()
    {
	return u + (v - u) * RandomNumberGenerator.nextDouble ();
    }
}
