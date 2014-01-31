//
//   This file contains the Java code from Program 11.7 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm11_07.txt
//
public class BinaryHeap
    extends AbstractContainer
    implements PriorityQueue
{
    protected Comparable[] array;

    public Comparable dequeueMin ()
    {
	if (count == 0)
	    throw new ContainerEmptyException ();
	Comparable result = array [1];
	Comparable last = array [count];
	--count;
	int i = 1;
	while (2 * i < count + 1)
	{
	    int child = 2 * i;
	    if (child + 1 < count + 1
		&& array [child + 1].isLT (array [child]))
		child += 1;
	    if (last.isLE (array [child]))
		break;
	    array [i] = array [child];
	    i = child;
	}
	array [i] = last;
	return result;
    }
    // ...
}
