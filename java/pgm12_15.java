//
//   This file contains the Java code from Program 12.15 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm12_15.txt
//
public class MultisetAsLinkedList
    extends AbstractSet
    implements Multiset
{
    protected LinkedList list;

    public Multiset union (Multiset set)
    {
	MultisetAsLinkedList arg = (MultisetAsLinkedList) set;
	if (universeSize != arg.universeSize)
	    throw new IllegalArgumentException (
		"mismatched sets");
	MultisetAsLinkedList result =
	    new MultisetAsLinkedList (universeSize);
	LinkedList.Element p = list.getHead ();
	LinkedList.Element q = arg.list.getHead ();
	while (p != null && q != null)
	{
	    if (((Int) p.getDatum ()).isLE (
		(Int) q.getDatum ()))
	    {
		result.list.append (p.getDatum ());
		p = p.getNext ();
	    }
	    else
	    {
		result.list.append (q.getDatum ());
		q = q.getNext ();
	    }
	}
	for ( ; p != null; p = p.getNext ())
	    result.list.append (p.getDatum ());
	for ( ; q != null; q = q.getNext ())
	    result.list.append (q.getDatum ());
	return result;
    }
    // ...
}
