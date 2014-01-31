//
//   This file contains the Java code from Program 6.19 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm06_19.txt
//
public class QueueAsLinkedList
    extends AbstractContainer
    implements Queue
{
    protected LinkedList list;

    public Object getHead ()
    {
	if (count == 0)
	    throw new ContainerEmptyException ();
	return list.getFirst ();
    }

    public void enqueue (Object object)
    {
	list.append (object);
	++count;
    }

    public Object dequeue ()
    {
	if (count == 0)
	    throw new ContainerEmptyException ();
	Object result = list.getFirst ();
	list.extract (result);
	--count;
	return result;
    }
    // ...
}
