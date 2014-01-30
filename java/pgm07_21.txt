//
//   This file contains the Java code from Program 7.21 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm07_21.txt
//
public class PolynomialAsOrderedList
    implements Polynomial
{
    OrderedList list;

    public PolynomialAsOrderedList ()
	{ list = new OrderedListAsLinkedList (); }

    public void add (Term term)
	{ list.insert (term); }

    public void differentiate ()
    {
	Visitor visitor = new AbstractVisitor ()
	{
	    public void visit (Object object)
		{ ((Term) object).differentiate (); }
	};
	list.accept (visitor);
	Comparable zeroTerm = list.find (new Term (0, 0));
	if (zeroTerm != null)
	    list.withdraw (zeroTerm);
    }
    // ...
}
