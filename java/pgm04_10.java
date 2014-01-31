//
//   This file contains the Java code from Program 4.10 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm04_10.txt
//
public interface Matrix
{
    double get (int i, int j);
    void put (int i, int j, double d);
    Matrix transpose ();
    Matrix times (Matrix matrix);
    Matrix plus (Matrix matrix);
}
