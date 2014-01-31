//
//   This file contains the Java code from Program 5.10 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm05_10.txt
//
public interface Visitor
{
    void visit (Object object);
    boolean isDone ();
}
