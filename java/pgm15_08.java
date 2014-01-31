//
//   This file contains the Java code from Program 15.8 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm15_08.txt
//
public abstract class AbstractQuickSorter
    extends AbstractSorter
{
    protected void sort ()
    {
	sort (0, n - 1);
	Sorter sorter = new StraightInsertionSorter ();
	sorter.sort (array);
    }
    // ...
}
