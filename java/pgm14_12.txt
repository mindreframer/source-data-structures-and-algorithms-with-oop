//
//   This file contains the Java code from Program 14.12 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm14_12.txt
//
public class Example
{
    public static void typeset (int[] l, int D, int s)
    {
	int n = l.length;
	int[][] L = new int [n][n];
	for (int i = 0; i < n; ++i)
	{
	    L [i][i] = l [i];
	    for (int j = i + 1; j < n; ++j)
		L [i][j] = L [i][j - 1] + l [j];
	}
	int[][] P = new int [n][n];
	for (int i = 0; i < n; ++i)
	    for (int j = i; j < n; ++j)
	    {
		if (L [i][j] < D)
		    P [i][j] = Math.abs (D - L[i][j] - (j-i)*s);
		else
		    P [i][j] = Integer.MAX_VALUE;
	    }
	int[][] c = new int [n][n];
	for (int j = 0; j < n; ++j)
	{
	    c [j][j] = P [j][j];
	    for (int i = j - 1; i >= 0; --i)
	    {
		int min = P [i][j];
		for (int k = i; k < j; ++k)
		{
		    int tmp = P [i][k] + c [k + 1][j];
		    if (tmp < min)
			min = tmp;
		}
		c [i][j] = min;
	    }
	}
    }
}
