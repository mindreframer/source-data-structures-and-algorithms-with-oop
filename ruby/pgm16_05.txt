#
# This file contains the Ruby code from Program 16.5 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm16_05.txt
#
class Graph < Container

    abstractmethod :directed?
    abstractmethod :connected?
    abstractmethod :cyclic?
    abstractmethod :vertices
    abstractmethod :edges
    abstractmethod :addVertex
    abstractmethod :getVertex
    abstractmethod :addEdge
    abstractmethod :getEdge
    abstractmethod :edge?
    abstractmethod :depthFirstTraversal
    abstractmethod :breadthFirstTraversal
    abstractmethod :incidentEdges
    abstractmethod :emanatingEdges

end
