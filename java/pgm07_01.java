//
//   This file contains the Java code from Program 7.1 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm07_01.txt
//
public interface OrderedList
    extends SearchableContainer
{
    Comparable get (int i);
    Cursor findPosition (Comparable object);
}
