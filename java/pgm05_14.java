//
//   This file contains the Java code from Program 5.14 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm05_14.txt
//
public interface SearchableContainer
    extends Container
{
    boolean isMember (Comparable object);
    void insert (Comparable object);
    void withdraw (Comparable obj);
    Comparable find (Comparable object);
}
