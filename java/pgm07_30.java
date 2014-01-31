//
//   This file contains the Java code from Program 7.30 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm07_30.txt
//
public class Term
    extends AbstractObject
{
    protected double coefficient;
    protected int exponent;

    public Term (Term term)
	{ this (term.coefficient, term.exponent); }

    public double getCoefficient ()
	{ return coefficient; }

    public int getExponent ()
	{ return exponent; }

    Term plus (Term arg)
    {
	if (exponent != arg.exponent)
	    throw new IllegalArgumentException (
		"unequal exponents");
	return new Term (
	    coefficient + arg.coefficient, exponent);
    }
}
    // ...
