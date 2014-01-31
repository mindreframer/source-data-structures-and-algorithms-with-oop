//
//   This file contains the Java code from Program 5.13 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm05_13.txt
//
public interface Enumeration
{
    boolean hasMoreElements ();
    Object nextElement ()
	throws NoSuchElementException;
}
