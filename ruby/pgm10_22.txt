#
# This file contains the Ruby code from Program 10.22 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm10_22.txt
#
module Algorithms

    def Algorithms.translate(dictionary, input, output)
        searchTree = AVLTree.new
        for line in dictionary.readlines
            words = line.split
	    assert { words.length == 2 }
            searchTree.insert(Association.new(words[0],words[1]))
	end
        for line in input.readlines
            for word in line.split
                assoc = searchTree.find(Association.new(word))
                if assoc.nil?
                    output.print word, " "
                else
                    output.print assoc.value, " "
		end
	    end
            output.print "\n"
	end
    end

end
