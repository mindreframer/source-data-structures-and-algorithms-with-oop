//
//   This file contains the Java code from Program 6.10 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm06_10.txt
//
public class StackAsLinkedList
    extends AbstractContainer
    implements Stack
{
    protected LinkedList list;

    public void accept (Visitor visitor)
    {
	for (LinkedList.Element ptr = list.getHead ();
	    ptr != null; ptr = ptr.getNext ())
	{
	    visitor.visit (ptr.getDatum ());
	    if (visitor.isDone ())
		return;
	}
    }
    // ...
}
