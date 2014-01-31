//
//   This file contains the Java code from Program 15.19 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm15_19.txt
//
public class RadixSorter
    extends AbstractSorter
{
    protected static final int r = 8;
    protected static final int R = 1 << r;
    protected static final int p = (32 + r - 1) / r;
    protected int[] count = new int [R];

    protected void sort ()
	{ sort ((Int[]) array); }
    // ...
}
