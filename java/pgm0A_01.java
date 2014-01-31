//
//   This file contains the Java code from Program A.1 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm0A_01.txt
//
public class Example
{
    public static void one ()
    {
	int y = 1;
	System.out.println (y);
	two (y);
	System.out.println (y);
    }

    public static void two (int x)
    {
	x = 2;
	System.out.println (x);
    }
}
