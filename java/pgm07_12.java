//
//   This file contains the Java code from Program 7.12 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm07_12.txt
//
public class OrderedListAsLinkedList
    extends AbstractSearchableContainer
    implements OrderedList
{
    protected LinkedList linkedList;

    public OrderedListAsLinkedList ()
	{ linkedList = new LinkedList (); }

    public void insert (Comparable object)
    {
	linkedList.append (object);
	++count;
    }

    public Comparable get (int offset)
    {
	if (offset < 0 || offset >= count)
	    throw new IndexOutOfBoundsException ();

	LinkedList.Element ptr = linkedList.getHead ();
	for (int i = 0; i < offset && ptr != null; ++i)
	    ptr = ptr.getNext ();
	return (Comparable) ptr.getDatum ();
    }
    // ...
}
