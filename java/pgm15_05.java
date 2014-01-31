//
//   This file contains the Java code from Program 15.5 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm15_05.txt
//
public class BubbleSorter
    extends AbstractSorter
{
    protected void sort ()
    {
	for (int i = n; i > 1; --i)
	    for (int j = 0; j < i - 1; ++j)
		if (array [j].isGT (array [j + 1]))
		    swap (j, j + 1);
    }
}
