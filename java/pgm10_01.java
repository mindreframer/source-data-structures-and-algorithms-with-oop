//
//   This file contains the Java code from Program 10.1 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm10_01.txt
//
public interface SearchTree
    extends Tree, SearchableContainer
{
    Comparable findMin ();
    Comparable findMax ();
}
