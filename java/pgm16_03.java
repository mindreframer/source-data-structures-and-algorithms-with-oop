//
//   This file contains the Java code from Program 16.3 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm16_03.txt
//
public interface Graph
    extends Container
{
    int getNumberOfEdges ();
    int getNumberOfVertices ();
    boolean isDirected ();
    void addVertex (int v);
    void addVertex (int v, Object weight);
    Vertex getVertex (int v);
    void addEdge (int v, int w);
    void addEdge (int v, int w, Object weight);
    Edge getEdge (int v, int w);
    boolean isEdge (int v, int w);
    boolean isConnected ();
    boolean isCyclic ();
    Enumeration getVertices ();
    Enumeration getEdges ();
    void depthFirstTraversal (PrePostVisitor visitor, int start);
    void breadthFirstTraversal (Visitor visitor, int start);
}
