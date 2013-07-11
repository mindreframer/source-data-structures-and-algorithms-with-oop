#
# This file contains the Ruby code from Program 5.9 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm05_09.txt
#
module SearchableContainerMethods

    abstractmethod :member?

    abstractmethod :insert

    abstractmethod :withdraw

    abstractmethod :find

end

class SearchableContainer < Container

    include SearchableContainerMethods

    def initialize
	super
    end

end
