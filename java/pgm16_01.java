//
//   This file contains the Java code from Program 16.1 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm16_01.txt
//
public interface Vertex
    extends Comparable
{
    int getNumber ();
    Object getWeight ();
    Enumeration getIncidentEdges ();
    Enumeration getEmanatingEdges ();
    Enumeration getPredecessors ();
    Enumeration getSuccessors ();
}
