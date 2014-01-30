//
//   This file contains the Java code from Program A.15 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm0A_15.txt
//
public class Example
{
    static class A extends Throwable 
	{}

    static void f () throws A
	{ throw new A (); }

    static void g ()
    {
	try
	{
	    f ();
	}
	catch (A exception)
	{
	    // ...
	}
    }
}
