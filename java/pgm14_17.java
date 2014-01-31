//
//   This file contains the Java code from Program 14.17 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm14_17.txt
//
public class ExponentialRV
    implements RandomVariable
{
    protected double mu = 1.;

    public ExponentialRV (double mu)
    {
	this.mu = mu;
    }

    public double nextDouble ()
    {
	return -mu * Math.log (
	    RandomNumberGenerator.nextDouble ());
    }
}
