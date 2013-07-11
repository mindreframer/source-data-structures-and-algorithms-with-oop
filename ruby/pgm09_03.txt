#
# This file contains the Ruby code from Program 9.3 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm09_03.txt
#
class PrePostVisitor < Visitor

    abstractmethod :preVisit

    abstractmethod :inVisit

    abstractmethod :postVisit

    alias_method :visit, :inVisit

end
