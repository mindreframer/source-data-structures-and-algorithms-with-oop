//
//   This file contains the Java code from Program 11.21 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm11_21.txt
//
public class BinomialQueue
    extends AbstractContainer
    implements MergeablePriorityQueue
{
    protected LinkedList treeList;

    public Comparable dequeueMin ()
    {
	if (count == 0)
	    throw new ContainerEmptyException ();

	BinomialTree minTree = findMinTree ();
	removeTree (minTree);

	BinomialQueue queue = new BinomialQueue ();
	while (minTree.getDegree () > 0)
	{
	    BinomialTree child =
		(BinomialTree) minTree.getSubtree (0);
	    minTree.detachSubtree (child);
	    queue.addTree (child);
	}
	merge (queue);

	return (Comparable) minTree.getKey ();
    }
    // ...
}
