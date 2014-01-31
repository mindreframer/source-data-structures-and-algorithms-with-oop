//
//   This file contains the Java code from Program 6.12 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm06_12.txt
//
public class Algorithms
{
    public static void calculator (Reader in, PrintWriter out)
	throws IOException
    {
	Stack stack = new StackAsLinkedList ();
	int i;
	while ((i = in.read ()) > 0)
	{
	    char c = (char) i;
	    if (Character.isDigit (c))
		stack.push (new Int (
		    Character.digit (c, 10)));
	    else if (c == '+')
	    {
		Int arg2 = (Int) stack.pop ();
		Int arg1 = (Int) stack.pop ();
		stack.push (new Int (
		    arg1.intValue () + arg2.intValue ()));
	    }
	    else if (c == '*')
	    {
		Int arg2 = (Int) stack.pop ();
		Int arg1 = (Int) stack.pop ();
		stack.push (new Int (
		    arg1.intValue () * arg2.intValue ()));
	    }
	    else if (c == '=')
	    {
		Int arg = (Int) stack.pop ();
		out.println (arg);
	    }
	}
    }
}
