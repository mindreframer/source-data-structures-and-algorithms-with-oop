//
//   This file contains the Java code from Program 6.11 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm06_11.txt
//
public class StackAsLinkedList
    extends AbstractContainer
    implements Stack
{
    protected LinkedList list;

    public Enumeration getEnumeration ()
    {
	return new Enumeration ()
	{
	    protected LinkedList.Element position =
		list.getHead ();

	    public boolean hasMoreElements ()
		{ return position != null; }

	    public Object nextElement ()
	    {
		if (position == null)
		    throw new NoSuchElementException ();
		Object result = position.getDatum ();
		position = position.getNext ();
		return result;
	    }
	};
    }
    // ...
}
