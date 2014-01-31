//
//   This file contains the Java code from Program 11.1 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm11_01.txt
//
public interface PriorityQueue
    extends Container
{
    void enqueue (Comparable object);
    Comparable findMin ();
    Comparable dequeueMin ();
}
