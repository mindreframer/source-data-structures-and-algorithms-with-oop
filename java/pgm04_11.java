//
//   This file contains the Java code from Program 4.11 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm04_11.txt
//
public class DenseMatrix
    implements Matrix
{
    protected int numberOfRows;
    protected int numberOfColumns;
    protected double[][] array;

    public DenseMatrix (int numberOfRows, int numberOfColumns)
    {
	this.numberOfRows = numberOfRows;
	this.numberOfColumns = numberOfColumns;
	array = new double[numberOfRows][numberOfColumns];
    }
    // ...
}
