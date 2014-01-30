//
//   This file contains the Java code from Program 5.8 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm05_08.txt
//
public interface Container
    extends Comparable
{
    int getCount ();
    boolean isEmpty ();
    boolean isFull ();
    void purge ();
    void accept (Visitor visitor);
    Enumeration getEnumeration ();
}
