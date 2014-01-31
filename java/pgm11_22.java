//
//   This file contains the Java code from Program 11.22 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm11_22.txt
//
public class Simulation
{
    static class Event
	extends Association
    {
	public static final int arrival = 0;
	public static final int departure = 1;

	Event (int type, double time)
	    { super (new Dbl (time), new Int (type)); }
	
	double getTime ()
	    { return ((Dbl) getKey ()).doubleValue (); }

	int getType ()
	    { return ((Int) getValue ()).intValue (); }
    }
    // ...
}
