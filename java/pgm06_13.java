//
//   This file contains the Java code from Program 6.13 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm06_13.txt
//
public interface Queue
    extends Container
{
    Object getHead ();
    void enqueue (Object object);
    Object dequeue ();
}
