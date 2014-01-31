//
//   This file contains the Java code from Program A.2 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm0A_02.txt
//
public class Example
{
    static class Obj
    {
	int field;

	public Obj (int arg)
	    { field = arg; }
	public void assign (int arg)
	    { field = arg; }
	public String toString ()
	    { return Integer.toString (field); }
    }

    public static void one ()
    {
	Obj y = new Obj (1);
	System.out.println (y);
	two (y);
	System.out.println (y);
    }

    public static void two (Obj x)
    {
	x.assign (2);
	System.out.println (x);
    }
}
