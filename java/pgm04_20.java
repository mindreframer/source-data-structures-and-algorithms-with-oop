//
//   This file contains the Java code from Program 4.20 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm04_20.txt
//
public class LinkedList
{
    protected Element head;
    protected Element tail;

    public void assign (LinkedList list)
    {
	if (list != this)
	{
	    purge ();
	    for (Element ptr = list.head;
		ptr != null; ptr = ptr.next)
	    {
		append (ptr.datum);
	    }
	}
    }
    // ...
}
