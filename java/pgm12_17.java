//
//   This file contains the Java code from Program 12.17 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm12_17.txt
//
public interface Partition
    extends Set
{
    Set find (int item);
    void join (Set set1, Set set2);
}
