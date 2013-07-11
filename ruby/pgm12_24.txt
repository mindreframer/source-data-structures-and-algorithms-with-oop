#
# This file contains the Ruby code from Program 12.24 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm12_24.txt
#
module Algorithms 

    def Algorithms.equivalenceClasses(input, output)
        line = input.readline
        p = PartitionAsForest.new(line.to_i)
        for line in input.readlines
            words = line.split
            i = words[0].to_i
            j = words[1].to_i
            s = p.find(i)
            t = p.find(j)
            if not s.equal?(t)
                p.join(s, t)
            else
                output.puts "redundant pair: %d, %d" % [i, j]
	    end
	end
        output.puts p
    end

end
