//
//   This file contains the Java code from Program A.11 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm0A_11.txt
//
public abstract class GraphicalObject
    implements GraphicsPrimitives
{
    protected Point center;

    public GraphicalObject (Point p)
	{ this.center = p; }

    public abstract void draw ();

    public void erase ()
    {
	setPenColor (backgroundColor);
	draw ();
	setPenColor (foregroundColor);
    }

    public void moveTo (Point p)
    {
	erase ();
	center = p;
	draw ();
    }
}
