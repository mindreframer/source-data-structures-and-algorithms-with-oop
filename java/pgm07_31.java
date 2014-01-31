//
//   This file contains the Java code from Program 7.31 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm07_31.txt
//
public class PolynomialAsSortedList
    implements Polynomial
{
    SortedList list;

    public Polynomial plus (Polynomial poly)
    {
	PolynomialAsSortedList arg =
	    (PolynomialAsSortedList) poly;
	Polynomial result = new PolynomialAsSortedList ();
	Enumeration p1 = list.getEnumeration ();
	Enumeration p2 = arg.list.getEnumeration ();
	Term term1 = null;
	Term term2 = null;
	while (p1.hasMoreElements () && p2.hasMoreElements ()) {
	    if (term1 == null) term1 = (Term) p1.nextElement ();
	    if (term2 == null) term2 = (Term) p2.nextElement ();
	    if (term1.getExponent () < term2.getExponent ()) {
		result.add (new Term (term1));
		term1 = null;
	    }
	    else if (term1.getExponent() > term2.getExponent()) {
		result.add (new Term (term2));
		term2 = null;
	    }
	    else {
		Term sum = term1.plus (term2);
		if (sum.getCoefficient () != 0)
		    result.add (sum);
		term1 = null;
		term2 = null;
	    }
	}
	while (term1 != null || p1.hasMoreElements ()) {
	    if (term1 == null) term1 = (Term) p1.nextElement ();
	    result.add (new Term (term1));
	    term1 = null;
	}
	while (term2 != null || p2.hasMoreElements ()) {
	    if (term2 == null) term2 = (Term) p2.nextElement ();
	    result.add (new Term (term2));
	    term2 = null;
	}
	return result;
    }
    // ...
}
