//
//   This file contains the Java code from Program 16.4 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm16_04.txt
//
public interface Digraph
    extends Graph
{
    boolean isStronglyConnected ();
    void topologicalOrderTraversal (Visitor visitor);
}
