#
# This file contains the Ruby code from Program 14.12 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm14_12.txt
#
require "singleton"

class RandomNumberGenerator

    include Singleton

    A = 16807
    M = 2147483647
    Q = 127773
    R = 2836

    def initialize(seed=1)
	super()
	assert { (1 ... M) === seed }
        @seed = seed
    end

    attr_reader :seed

    def seed=(seed)
	assert { (1 ... M) === seed }
        @seed = seed
    end

    def next
        @seed = A * (@seed % Q) - R * (@seed / Q)
	@seed += M if @seed < 0
        return (1.0 * @seed) / M
    end

end
