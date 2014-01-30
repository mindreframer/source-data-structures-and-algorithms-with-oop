//
//   This file contains the Java code from Program 15.6 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm15_06.txt
//
public abstract class AbstractQuickSorter
    extends AbstractSorter
{
    protected static final int cutOff = 2; // minimum cut-off

    protected abstract int selectPivot (int left, int right);
    // ...
}
