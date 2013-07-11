#
# This file contains the Ruby code from Program 12.17 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm12_17.txt
#
class PartitionAsForest < Partition

    class PartitionTree < Tree

        def initialize(partition, item)
            super()
	    @universeSize = partition.universeSize
            @partition = partition
            @item = item
            @parent = nil
            @rank = 0
            @count = 1
	end

	attr_reader :partition
	attr_accessor :parent
	attr_accessor :rank
	attr_accessor :count

    end

end
