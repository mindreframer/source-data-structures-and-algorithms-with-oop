//
//   This file contains the Java code from Program A.12 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm0A_12.txt
//
public class Circle
    extends GraphicalObject
{
    int radius;

    public Circle (Point p, int r)
    {
	super (p);
	radius = r;
    }

    public void draw ()
	{ /* ... */ }
}
