//
//   This file contains the Java code from Program 14.10 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm14_10.txt
//
public class Example
{
    public static int fibonacci (int n, int k)
    {
	if (n < k - 1)
	    return 0;
	else if (n == k - 1)
	    return 1;
	else
	{
	    int[] f = new int [n + 1];
	    for (int i = 0; i < k - 1; ++i)
		f [i] = 0;
	    f [k - 1] = 1;
	    for (int i = k; i <= n; ++i)
	    {
		int sum = 0;
		for (int j = 1; j <= k; ++j)
		    sum += f [i - j];
		f [i] = sum;
	    }
	    return f [n];
	}
    }
}
