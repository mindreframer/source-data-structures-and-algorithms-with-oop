#
# This file contains the Ruby code from Program 3.5 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm03_05.txt
#
def bucketSort(a, n, buckets, m)
    for j in 0 ... m
        buckets[j] = 0
    end
    for i in 0 ... n
        buckets[a[i]] += 1
    end
    i = 0
    for j in 0 ... m
        for k in 0 ... buckets[j]
            a[i] = j
            i += 1
	end
    end
end
