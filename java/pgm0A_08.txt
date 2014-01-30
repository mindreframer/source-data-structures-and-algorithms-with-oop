//
//   This file contains the Java code from Program A.8 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm0A_08.txt
//
public class Parent
    extends Person
{
    protected Person[] children;

    public Parent (String name, int sex, Person[] children)
    {
	super (name, sex);
	this.children = children;
    }

    public Person getChild (int i)
	{ return children [i]; }

    public String toString ()
	{ /* ... */ }
}
