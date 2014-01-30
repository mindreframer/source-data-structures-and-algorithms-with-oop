//
//   This file contains the Java code from Program 12.1 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm12_01.txt
//
public interface Set
    extends SearchableContainer
{
    Set union (Set set);
    Set intersection (Set set);
    Set difference (Set set);
    boolean isEQ (Set set);
    boolean isSubset (Set set);
}
