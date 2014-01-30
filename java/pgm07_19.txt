//
//   This file contains the Java code from Program 7.19 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm07_19.txt
//
public class Term
    extends AbstractObject
{
    protected double coefficient;
    protected int exponent;

    public Term (double coefficient, int exponent)
    {
	this.coefficient = coefficient;
	this.exponent = exponent;
    }

    protected int compareTo (Comparable object)
    {
	Term term = (Term) object;
	if (exponent == term.exponent)
	{
	    if (coefficient < term.coefficient)
		return -1;
	    else if (coefficient > term.coefficient)
		return +1;
	    else
		return 0;
	}
	else
	    return exponent - term.exponent;
    }

    public void differentiate ()
    {
	if (exponent > 0)
	{
	    coefficient *= exponent;
	    exponent -= 1;
	}
	else
	    coefficient = 0;
    }
}
    // ...
