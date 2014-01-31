//
//   This file contains the Java code from Program 8.22 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm08_22.txt
//
public class OpenScatterTableV2
    extends OpenScatterTable
{
    public void withdraw (Comparable object)
    {
	if (count == 0)
	    throw new ContainerEmptyException ();
	int i = findInstance (object);
	if (i < 0)
	    throw new IllegalArgumentException (
		"object not found");
	for (;;)
	{
	    int j = (i + 1) % getLength ();
	    while (array [j].state == occupied)
	    {
		int h = h (array [j].object);
		if ((h <= i && i < j) || (i < j && j < h) ||
		    (j < h && h <= i))
		    break;
		j = (j + 1) % getLength ();
	    }
	    if (array [j].state == empty)
		break;
	    array [i].state = array [j].state;
	    array [i].object = array [j].object;
	    i = j;
	}
	array [i].state = empty;
	array [i].object = null;
	--count;
    }
    // ...
}
