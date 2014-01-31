//
//   This file contains the Java code from Program 6.21 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm06_21.txt
//
public interface Deque
    extends Container
{
    Object getHead ();
    Object getTail ();
    void enqueueHead (Object object);
    void enqueueTail (Object object);
    Object dequeueHead ();
    Object dequeueTail ();
}
