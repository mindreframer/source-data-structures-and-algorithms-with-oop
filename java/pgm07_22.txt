//
//   This file contains the Java code from Program 7.22 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm07_22.txt
//
public interface SortedList
    extends SearchableContainer
{
    Comparable get (int i);
    Cursor findPosition (Comparable object);
}
