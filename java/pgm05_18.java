//
//   This file contains the Java code from Program 5.18 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm05_18.txt
//
public class Association
    extends AbstractObject
{
    protected Comparable key;
    protected Object value;

    protected int compareTo (Comparable object)
    {
	Association association = (Association) object;
	return key.compare (association.getKey ());
    }

    public String toString ()
    {
	String result = "Association {" + key;
	if (value != null)
	    result += ", " + value;
	return result + "}";
    }
    // ...
}
