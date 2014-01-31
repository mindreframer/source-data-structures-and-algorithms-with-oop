//
//   This file contains the Java code from Program 6.5 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm06_05.txt
//
public class StackAsArray
    extends AbstractContainer
    implements Stack
{
    protected Object[] array;

    public void accept (Visitor visitor)
    {
	for (int i = 0; i < count; ++i)
	{
	    visitor.visit (array [i]);
	    if (visitor.isDone ())
		return;
	}
    }
    // ...
}
