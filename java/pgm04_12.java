//
//   This file contains the Java code from Program 4.12 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm04_12.txt
//
public class DenseMatrix
    implements Matrix
{
    protected int numberOfRows;
    protected int numberOfColumns;
    protected double[][] array;

    public Matrix times (Matrix mat)
    {
	DenseMatrix arg = (DenseMatrix) mat;
	if (numberOfColumns != arg.numberOfRows)
	    throw new IllegalArgumentException (
		"incompatible matrices");
	DenseMatrix result =
	    new DenseMatrix (numberOfRows, arg.numberOfColumns);
	for (int i = 0; i < numberOfRows; ++i)
	{
	    for (int j = 0; j < arg.numberOfColumns; ++j)
	    {
		double sum = 0;
		for (int k = 0; k < numberOfColumns; ++k)
		    sum += array [i][k] * arg.array [k][j];
		result.array [i][j] = sum;
	    }
	}
	return result;
    }
    // ...
}
