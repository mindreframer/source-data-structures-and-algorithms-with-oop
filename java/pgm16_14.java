//
//   This file contains the Java code from Program 16.14 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm16_14.txt
//
public class Algorithms
{
    static final class Entry
    {
	boolean known = false;
	int distance = Integer.MAX_VALUE;
	int predecessor = Integer.MAX_VALUE;
    }
}
