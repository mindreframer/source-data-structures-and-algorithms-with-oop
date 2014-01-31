//
//   This file contains the Java code from Program 15.17 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm15_17.txt
//
public class BucketSorter
    extends AbstractSorter
{
    protected int m;
    protected int[] count;

    public BucketSorter (int m)
    {
	this.m = m;
	count = new int [m];
    }
    
    protected void sort ()
	{ sort ((Int[]) array); }
    // ...
}
