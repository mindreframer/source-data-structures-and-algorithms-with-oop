//
//   This file contains the Java code from Program 12.10 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm12_10.txt
//
public interface Multiset
    extends SearchableContainer
{
    Multiset union (Multiset set);
    Multiset intersection (Multiset set);
    Multiset difference (Multiset set);
    boolean isEQ (Multiset set);
    boolean isSubset (Multiset set);
}
