//
//   This file contains the Java code from Program 6.9 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm06_09.txt
//
public class StackAsLinkedList
    extends AbstractContainer
    implements Stack
{
    protected LinkedList list;

    public void push (Object object)
    {
	list.prepend (object);
	++count;
    }

    public Object pop ()
    {
	if (count == 0)
	    throw new ContainerEmptyException ();
	Object result = list.getFirst ();
	list.extract (result);
	--count;
	return result;
    }

    public Object getTop ()
    {
	if (count == 0)
	    throw new ContainerEmptyException ();
	return list.getFirst ();
    }
    // ...
}
