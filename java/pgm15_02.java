//
//   This file contains the Java code from Program 15.2 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm15_02.txt
//
public abstract class AbstractSorter
    implements Sorter
{
    protected Comparable[] array;
    protected int n;

    protected abstract void sort ();

    public final void sort (Comparable[] array)
    {
	n = array.length;
	this.array = array;
	if (n > 0)
	    sort ();
	this.array = null;
    }

    protected final void swap (int i, int j)
    {
	Comparable tmp = array [i];
	array [i] = array [j];
	array [j] = tmp;
    }
}
