//
//   This file contains the Java code from Program 9.3 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm09_03.txt
//
public interface PrePostVisitor
{
    void preVisit (Object object);
    void inVisit (Object object);
    void postVisit (Object object);
    boolean isDone ();
}
