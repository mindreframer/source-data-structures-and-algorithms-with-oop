//
//   This file contains the Java code from Program 5.1 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm05_01.txt
//
public interface Comparable
{
    boolean isLT (Comparable object);
    boolean isLE (Comparable object);
    boolean isGT (Comparable object);
    boolean isGE (Comparable object);
    boolean isEQ (Comparable object);
    boolean isNE (Comparable object);
    int compare (Comparable object);
}
