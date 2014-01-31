//
//   This file contains the Java code from Program 9.4 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm09_04.txt
//
public abstract class AbstractPrePostVisitor
    implements PrePostVisitor
{
    public void preVisit (Object object)
	{}
    public void inVisit (Object object)
	{}
    public void postVisit (Object object)
	{}
    public boolean isDone ()
	{ return false; }
}
