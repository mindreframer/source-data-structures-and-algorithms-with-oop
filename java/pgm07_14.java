//
//   This file contains the Java code from Program 7.14 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm07_14.txt
//
public class OrderedListAsLinkedList
    extends AbstractSearchableContainer
    implements OrderedList
{
    protected LinkedList linkedList;

    public void withdraw (Comparable object)
    {
	if (count == 0)
	    throw new ContainerEmptyException ();
	linkedList.extract (object);
	--count;
    }
    // ...
}
