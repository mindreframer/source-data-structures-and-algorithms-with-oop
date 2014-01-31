//
//   This file contains the Java code from Program 9.7 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm09_07.txt
//
public class PostOrder
    extends AbstractPrePostVisitor
{
    protected Visitor visitor;

    public PostOrder (Visitor visitor)
	{ this.visitor = visitor; }

    public void postVisit (Object object)
	{ visitor.visit (object); }
    
    public boolean isDone ()
	{ return visitor.isDone (); }
}
