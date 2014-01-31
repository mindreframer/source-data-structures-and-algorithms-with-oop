//
//   This file contains the Java code from Program 9.5 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm09_05.txt
//
public class PreOrder
    extends AbstractPrePostVisitor
{
    protected Visitor visitor;

    public PreOrder (Visitor visitor)
	{ this.visitor = visitor; }

    public void preVisit (Object object)
	{ visitor.visit (object); }
    
    public boolean isDone ()
	{ return visitor.isDone (); }
}
