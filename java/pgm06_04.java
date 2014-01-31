//
//   This file contains the Java code from Program 6.4 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm06_04.txt
//
public class StackAsArray
    extends AbstractContainer
    implements Stack
{
    protected Object[] array;

    public void push (Object object)
    {
	if (count == array.length)
	    throw new ContainerFullException ();
	array [count++] = object;
    }

    public Object pop ()
    {
	if (count == 0)
	    throw new ContainerEmptyException ();
	Object result = array [--count];
	array [count] = null;
	return result;
    }

    public Object getTop ()
    {
	if (count == 0)
	    throw new ContainerEmptyException ();
	return array [count - 1];
    }
    // ...
}
