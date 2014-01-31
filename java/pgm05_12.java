//
//   This file contains the Java code from Program 5.12 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm05_12.txt
//
public abstract class AbstractContainer
    extends AbstractObject
    implements Container
{
    protected int count;

    public String toString ()
    {
	final StringBuffer buffer = new StringBuffer ();
	Visitor visitor = new AbstractVisitor ()
	{
	    private boolean comma;

	    public void visit (Object object)
	    {
		if (comma)
		    buffer.append (", ");
		buffer.append (object);
		comma = true;
	    }
	};
	accept (visitor);
	return getClass ().getName () + " {" + buffer + "}";
    }
    // ...
}
