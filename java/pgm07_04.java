//
//   This file contains the Java code from Program 7.4 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm07_04.txt
//
public class OrderedListAsArray
    extends AbstractSearchableContainer
    implements OrderedList
{
    protected Comparable[] array;

    public OrderedListAsArray (int size)
	{ array = new Comparable [size]; }

    public void insert (Comparable object)
    {
	if (count == array.length)
	    throw new ContainerFullException ();
	array [count] = object;
	++count;
    }
    // ...
}
