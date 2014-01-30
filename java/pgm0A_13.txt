//
//   This file contains the Java code from Program A.13 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm0A_13.txt
//
public class Rectangle
    extends GraphicalObject
{
    protected int height;
    protected int width;

    public Rectangle (Point p, int ht, int wid)
    {
	super (p);
	height = ht;
	width = wid;
    }

    public void draw ()
	{ /* ... */ }
}
