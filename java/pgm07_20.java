//
//   This file contains the Java code from Program 7.20 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm07_20.txt
//
public interface Polynomial
{
    void add (Term term);
    void differentiate ();
    Polynomial plus (Polynomial polynomial);
}
