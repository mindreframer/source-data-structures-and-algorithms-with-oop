//
//   This file contains the Java code from Program 12.25 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm12_25.txt
//
public class Algorithms
{
    public static void equivalenceClasses (
	Reader in, PrintWriter out)
	throws IOException
    {
	StreamTokenizer tin = new StreamTokenizer (in);
	tin.parseNumbers ();
	if (tin.nextToken () != StreamTokenizer.TT_NUMBER)
	    throw new DomainException ("invalid input");
	int n = (int) tin.nval;
	Partition p = new PartitionAsForest (n);

	int i;
	int j;
	for (;;)
	{
	    if (tin.nextToken () != StreamTokenizer.TT_NUMBER)
		break;
	    i = (int) tin.nval;
	    if (tin.nextToken () != StreamTokenizer.TT_NUMBER)
		break;
	    j = (int) tin.nval;
	    Set s = p.find (i);
	    Set t = p.find (j);
	    if (s != t)
		p.join (s, t);
	    else
		out.println ("redundant pair: " + i + ", " + j);
	}
	out.println (p);
    }
}
