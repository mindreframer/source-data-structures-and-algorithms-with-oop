//
//   This file contains the Java code from Program 8.4 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm08_04.txt
//
public abstract class AbstractContainer
    extends AbstractObject
    implements Container
{
    protected int count;

    public int hashCode ()
    {
	Visitor visitor = new AbstractVisitor ()
	{
	    private int value;

	    public void visit (Object object)
		{ value += object.hashCode (); }

	    public int hashCode ()
		{ return value; }
	};
	accept (visitor);
	return getClass ().hashCode () + visitor.hashCode ();
    }
    // ...
}
