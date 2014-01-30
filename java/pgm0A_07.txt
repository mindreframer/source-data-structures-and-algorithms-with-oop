//
//   This file contains the Java code from Program A.7 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm0A_07.txt
//
public class Person
{
    public final int male = 0;
    public final int female = 1;

    protected String name;
    protected int sex;

    public Person (String name, int sex)
    {
	this.name = name;
	this.sex = sex;
    }

    public String toString ()
	{ return name; }
}
