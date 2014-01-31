//
//   This file contains the Java code from Program 5.11 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm05_11.txt
//
public abstract class AbstractVisitor
    implements Visitor
{
    public void visit (Object object)
	{}
    public boolean isDone ()
	{ return false; }
}
