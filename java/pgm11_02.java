//
//   This file contains the Java code from Program 11.2 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm11_02.txt
//
public interface MergeablePriorityQueue
    extends PriorityQueue
{
    void merge (MergeablePriorityQueue queue);
}
