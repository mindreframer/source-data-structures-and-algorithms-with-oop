//
//   This file contains the Java code from Program 15.18 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm15_18.txt
//
public class BucketSorter
    extends AbstractSorter
{
    protected int m;
    protected int[] count;

    protected void sort (Int[] array)
    {
	for (int i = 0; i < m; ++i)
	    count [i] = 0;
	for (int j = 0; j < n; ++j)
	    ++count [array [j].intValue ()];
	for (int i = 0, j = 0; i < m; ++i)
	    for ( ; count [i] > 0; --count [i])
		array [j++] = new Int (i);
    }
    // ...
}
