//
//   This file contains the Java code from Program 8.16 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm08_16.txt
//
public class ChainedScatterTable
    extends AbstractHashTable
{
    protected Entry[] array;

    public void withdraw (Comparable object)
    {
	if (count == 0)
	    throw new ContainerEmptyException ();
	int i = h (object);
	while (i != nil && object != array [i].object)
	    i = array [i].next;
	if (i == nil)
	    throw new IllegalArgumentException ("obj not found");
	for (;;)
	{   int j = array [i].next;
	    while (j != nil)
	    {   int h = h (array [j].object);
		boolean contained = false;
		for (int k = array [i].next;
		    k != array [j].next && !contained;
		    k = array [k].next)
		{
		    if (k == h) contained = true;
		}
		if (!contained) break;
		j = array [j].next;
	    }
	    if (j == nil) break;
	    array [i].object = array [j].object;
	    i = j;
	}
	array [i].object = null;
	array [i].next = nil;
	for (int j = (i + getLength () - 1) % getLength ();
	    j != i; j = (j + getLength () - 1) % getLength ())
	{   if (array [j].next == i)
	    {
		array [j].next = nil;
		break;
	    }
	}
	--count;
    }
    // ...
}
