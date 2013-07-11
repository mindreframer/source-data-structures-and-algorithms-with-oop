#
# This file contains the Ruby code from Program 9.6 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm09_06.txt
#
class PostOrder < PrePostVisitor

    def initialize(visitor)
	super()
        @visitor = visitor
    end

    def preVisit(obj)
    end

    def inVisit(obj)
    end

    def postVisit(obj)
        @visitor.visit(obj)
    end
    
    def done?
	@visitor.done?
    end
