//
//   This file contains the Java code from Program 9.26 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm09_26.txt
//
public class ExpressionTree
    extends BinaryTree
{
    public String toString ()
    {
	final StringBuffer buffer = new StringBuffer ();
	PrePostVisitor visitor = new AbstractPrePostVisitor ()
	{
	    public void preVisit (Object object)
		{ buffer.append ("("); }
	    public void inVisit (Object object)
		{ buffer.append (object); }
	    public void postVisit (Object object)
		{ buffer.append (")"); }
	};
	depthFirstTraversal (visitor);
	return buffer.toString ();
    }
    // ...
}
