#
# This file contains the Ruby code from Program 14.2 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm14_02.txt
#
class Solver < AbstractObject

    def initialize
        @bestSolution = nil
        @bestObjective = Fixnum::MAX
    end

    abstractmethod :search

    def solve(initial)
        assert { initial.is_a?(Solution) }
        @bestSolution = nil
        @bestObjective = Fixnum::MAX
        search(initial)
        return @bestSolution
    end

    def updateBest(solution)
        if solution.complete? and solution.feasible? and \
                solution.objective < @bestObjective
            @bestSolution = solution
            @bestObjective = solution.objective
	end
    end

end
