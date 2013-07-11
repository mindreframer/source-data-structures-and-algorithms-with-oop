#
# This file contains the Ruby code from Program 8.21 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm08_21.txt
#
module Algorithms

    def Algorithms.wordCounter(input, output)
        table = ChainedHashTable.new(1031)
        for line in input.readlines
            for word in line.split
                assoc = table.find(Association.new(word))
                if assoc.nil?
                    table.insert(Association.new(word, 1))
                else
		    assoc.value += 1
		end
	    end
	end
        output.puts table
    end

end
