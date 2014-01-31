//
//   This file contains the Java code from Program 11.18 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm11_18.txt
//
public class BinomialQueue
    extends AbstractContainer
    implements MergeablePriorityQueue
{
    protected LinkedList treeList;

    public void merge (MergeablePriorityQueue queue)
    {
	BinomialQueue arg = (BinomialQueue) queue;
	LinkedList oldList = treeList;
	treeList = new LinkedList ();
	count = 0;
	LinkedList.Element p = oldList.getHead ();
	LinkedList.Element q = arg.treeList.getHead();
	BinomialTree carry = null;
	for (int i = 0; p!=null || q!=null || carry!=null; ++i)
	{
	    BinomialTree a = null;
	    if (p != null)
	    {
		BinomialTree tree = (BinomialTree) p.getDatum ();
		if (tree.getDegree () == i)
		{
		    a = tree;
		    p = p.getNext ();
		}
	    }
	    BinomialTree b = null;
	    if (q != null)
	    {
		BinomialTree tree = (BinomialTree) q.getDatum ();
		if (tree.getDegree () == i)
		{
		    b = tree;
		    q = q.getNext ();
		}
	    }
	    BinomialTree sum = sum (a, b, carry);
	    if (sum != null)
		addTree (sum);
	    carry = carry (a, b, carry);
	}
	arg.purge ();
    }
    // ...
}
