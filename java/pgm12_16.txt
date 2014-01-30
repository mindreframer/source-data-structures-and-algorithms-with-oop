//
//   This file contains the Java code from Program 12.16 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm12_16.txt
//
public class MultisetAsLinkedList
    extends AbstractSet
    implements Multiset
{
    protected LinkedList list;

    public Multiset intersection (Multiset set)
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
	    int diff = ((Int) p.getDatum ()).compare (
		(Int) q.getDatum ());
	    if (diff == 0)
		result.list.append (p.getDatum ());
	    if (diff <= 0)
		p = p.getNext ();
	    if (diff >= 0)
		q = q.getNext ();
	}
	return result;
    }
    // ...
}
