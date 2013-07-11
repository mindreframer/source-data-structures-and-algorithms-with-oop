#
# This file contains the Ruby code from Program 14.8 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm14_08.txt
#
def mergeSort(array, i, n)
    if n > 1
        mergeSort(array, i, n / 2)
        mergeSort(array, i + n / 2, n - n / 2)
        merge(array, i, n / 2, n - n / 2)
    end
end
