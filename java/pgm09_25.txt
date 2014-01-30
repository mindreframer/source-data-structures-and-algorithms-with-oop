//
//   This file contains the Java code from Program 9.25 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm09_25.txt
//
public class ExpressionTree
    extends BinaryTree
{
    public ExpressionTree (char c)
	{ super (new Chr (c)); }
    
    public static ExpressionTree parsePostfix (Reader in)
	throws IOException
    {
	Stack stack = new StackAsLinkedList ();

	int i;
	while ((i = in.read ()) >= 0)
	{
	    char c = (char) i;
	    if (Character.isLetterOrDigit (c))
		stack.push (new ExpressionTree (c));
	    else if (c == '+' || c == '-' || c == '*' || c =='/')
	    {
		ExpressionTree result = new ExpressionTree (c);
		result.attachRight((ExpressionTree) stack.pop());
		result.attachLeft ((ExpressionTree) stack.pop());
		stack.push (result);
	    }
	}
	return (ExpressionTree) stack.pop ();
    }
    // ...
}
