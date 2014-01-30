//
//   This file contains the Java code from Program 8.23 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm08_23.txt
//
public class Algorithms
{
    private static final class Counter
	extends Int
    {
	Counter (int value)
	    { super (value); }
	void increment ()
	    { ++value; }
    }

    public static void wordCounter (Reader in, PrintWriter out)
	throws IOException
    {
	HashTable table = new ChainedHashTable (1031);
	StreamTokenizer tin = new StreamTokenizer (in);
	while (tin.nextToken () != StreamTokenizer.TT_EOF)
	{
	    String word = tin.sval;

	    Object obj = table.find (
		new Association (new Str (word)));

	    if (obj == null)
		table.insert (new Association (
		    new Str (word), new Counter (1)));
	    else
	    {
		Association assoc = (Association) obj;
		Counter counter = (Counter) assoc.getValue ();
		counter.increment ();
	    }
	}
	out.println (table);
    }
}
