//
//   This file contains the Java code from Program 10.23 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm10_23.txt
//
public class Algorithms
{
    public static void translate (Reader dictionary,
	Reader inputText, PrintWriter outputText)
	throws IOException
    {
	SearchTree searchTree = new AVLTree ();
	StreamTokenizer tin = new StreamTokenizer (dictionary);
	for (;;)
	{
	    if (tin.nextToken () == StreamTokenizer.TT_EOF)
		break;
	    Comparable key = new Str (tin.sval);

	    if (tin.nextToken () == StreamTokenizer.TT_EOF)
		break;
	    String value = tin.sval;

	    searchTree.insert (new Association (key, value));
	}

	tin = new StreamTokenizer (inputText);
	while (tin.nextToken () != StreamTokenizer.TT_EOF)
	{
	    Comparable word = new Str (tin.sval);
	    Object obj = searchTree.find (new Association(word));
	    if (obj == null)
		outputText.println ("?");
	    else
	    {
		Association assoc = (Association) obj;
		outputText.println (assoc.getValue ());
	    }
	}
    }
}
