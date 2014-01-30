//
//   This file contains the Java code from Program 15.20 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm15_20.txt
//
public class RadixSorter
    extends AbstractSorter
{
    protected void sort (Int[] array)
    {
	Int[] tempArray = new Int [n];

	for (int i = 0; i < p; ++i)
	{
	    for (int j = 0; j < R; ++j)
		count [j] = 0;
	    for (int k = 0; k < n; ++k)
	    {
		++count[(array[k].intValue() >>> (r*i)) & (R-1)];
		tempArray [k] = array [k];
	    }
	    int pos = 0;
	    for (int j = 0; j < R; ++j)
	    {
		int tmp = pos;
		pos += count [j];
		count [j] = tmp;
	    }
	    for (int k = 0; k < n; ++k)
	    {
		int j = (tempArray[k].intValue()>>>(r*i))&(R-1);
		array [count [j]++] = tempArray [k];
	    }
	}
    }
    // ...
}
