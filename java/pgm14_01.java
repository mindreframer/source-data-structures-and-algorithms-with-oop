//
//   This file contains the Java code from Program 14.1 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm14_01.txt
//
public interface Solution
    extends Comparable, Cloneable
{
    boolean isFeasible ();
    boolean isComplete ();
    int getObjective ();
    int getBound ();
    Enumeration getSuccessors ();
}
