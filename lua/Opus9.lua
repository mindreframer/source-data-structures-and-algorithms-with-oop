#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/12 14:26:31 $
    $RCSfile: Opus9.lua,v $
    $Revision: 1.3 $

    $Id: Opus9.lua,v 1.3 2004/12/12 14:26:31 brpreiss Exp $

--]]

require "Algorithms"
require "Application11"
require "Application12"
require "Application1"
require "Application2"
require "Application3"
require "Application4"
require "Application5"
require "Application6"
require "Application7"
require "Application8"
require "Application9"
require "Array"
require "Association"
require "AVLTree"
require "BinaryHeap"
require "BinaryInsertionSorter"
require "BinarySearchTree"
require "BinaryTree"
require "BinomialQueue"
require "BreadthFirstBranchAndBoundSolver"
require "BreadthFirstSolver"
require "BTree"
require "BubbleSorter"
require "BucketSorter"
require "ChainedHashTable"
require "ChainedScatterTable"
require "Circle"
require "Class"
require "Complex"
require "Container"
require "Cursor"
require "Deap"
require "Demo10"
require "Demo1"
require "Demo2"
require "Demo3"
require "Demo4"
require "Demo5"
require "Demo6"
require "Demo7"
require "Demo9"
require "DenseMatrix"
require "DepthFirstBranchAndBoundSolver"
require "DepthFirstSolver"
require "DequeAsArray"
require "DequeAsLinkedList"
require "Deque"
require "DigraphAsLists"
require "DigraphAsMatrix"
require "Digraph"
require "DoubleEndedPriorityQueue"
require "Edge"
require "Example"
require "Experiment1"
require "Experiment2"
require "ExponentialRV"
require "ExpressionTree"
require "GeneralTree"
require "GraphAsLists"
require "GraphAsMatrix"
require "GraphicalObject"
require "Graph"
require "HashTable"
require "HeapSorter"
require "Integer"
require "LeftistHeap"
require "LinkedList"
require "Matrix"
require "MedianOfThreeQuickSorter"
require "MergeablePriorityQueue"
require "Meta"
require "Module"
require "MultiDimensionalArray"
require "MultisetAsArray"
require "MultisetAsLinkedList"
require "Multiset"
require "MWayTree"
require "NaryTree"
require "Number"
require "Object"
require "OpenScatterTable"
require "OpenScatterTableV2"
require "OrderedListAsArray"
require "OrderedListAsLinkedList"
require "OrderedList"
require "Parent"
require "PartitionAsForest"
require "PartitionAsForestV2"
require "PartitionAsForestV3"
require "Partition"
require "Person"
require "Point"
require "PolynomialAsOrderedList"
require "PolynomialAsSortedList"
require "Polynomial"
require "PriorityQueue"
require "QueueAsArray"
require "QueueAsLinkedList"
require "Queue"
require "QuickSorter"
require "RadixSorter"
require "RandomNumberGenerator"
require "RandomVariable"
require "Rectangle"
require "ScalesBalancingProblem"
require "SearchableContainer"
require "SearchTree"
require "SetAsArray"
require "SetAsBitVector"
require "Set"
require "SimpleRV"
require "Simulation"
require "Solution"
require "Solver"
require "SortedListAsArray"
require "SortedListAsLinkedList"
require "SortedList"
require "Sorter"
require "SparseMatrixAsArray"
require "SparseMatrixAsLinkedList"
require "SparseMatrixAsVector"
require "SparseMatrix"
require "Square"
require "StackAsArray"
require "StackAsLinkedList"
require "Stack"
require "StraightInsertionSorter"
require "StraightSelectionSorter"
require "String"
require "Timer"
require "Tree"
require "TwoWayMergeSorter"
require "UniformRV"
require "Vertex"
require "ZeroOneKnapsackProblem"

-- The Opus9 module.
Opus9 = Module.new("Opus9")

function Opus9.main(arg)
    print(Algorithms:dump())
    print(Algorithms.Entry:dump())
    print(Application11:dump())
    print(Application12:dump())
    print(Application1:dump())
    print(Application2:dump())
    print(Application3:dump())
    print(Application4:dump())
    print(Application5:dump())
    print(Application6:dump())
    print(Application7:dump())
    print(Application8:dump())
    print(Application9:dump())
    print(Array:dump())
    print(Association:dump())
    print(AVLTree:dump())
    print(BinaryHeap:dump())
    print(BinaryInsertionSorter:dump())
    print(BinarySearchTree:dump())
    print(BinaryTree:dump())
    print(BinomialQueue:dump())
    print(BreadthFirstBranchAndBoundSolver:dump())
    print(BreadthFirstSolver:dump())
    print(BTree:dump())
    print(BubbleSorter:dump())
    print(BucketSorter:dump())
    print(ChainedHashTable:dump())
    print(ChainedScatterTable:dump())
    print(ChainedScatterTable.Entry:dump())
    print(Circle:dump())
    print(Class:dump())
    print(Complex:dump())
    print(Container:dump())
    print(Cursor:dump())
    print(Deap:dump())
    print(Demo10:dump())
    print(Demo1:dump())
    print(Demo2:dump())
    print(Demo3:dump())
    print(Demo4:dump())
    print(Demo5:dump())
    print(Demo6:dump())
    print(Demo7:dump())
    print(Demo9:dump())
    print(DenseMatrix:dump())
    print(DepthFirstBranchAndBoundSolver:dump())
    print(DepthFirstSolver:dump())
    print(DequeAsArray:dump())
    print(DequeAsLinkedList:dump())
    print(Deque:dump())
    print(DigraphAsLists:dump())
    print(DigraphAsMatrix:dump())
    print(Digraph:dump())
    print(DoubleEndedPriorityQueue:dump())
    print(Edge:dump())
    print(Example:dump())
    print(Experiment1:dump())
    print(Experiment2:dump())
    print(ExponentialRV:dump())
    print(ExpressionTree:dump())
    print(GeneralTree:dump())
    print(GraphAsLists:dump())
    print(GraphAsMatrix:dump())
    print(Graph:dump())
    print(Graph.Edge:dump())
    print(GraphicalObject:dump())
    print(Graph.Vertex:dump())
    print(HashTable:dump())
    print(HeapSorter:dump())
    print(Integer:dump())
    print(LeftistHeap:dump())
    print(LinkedList:dump())
    print(LinkedList.Element:dump())
    print(Matrix:dump())
    print(MedianOfThreeQuickSorter:dump())
    print(MergeablePriorityQueue:dump())
    --print(Meta:dump())
    print(Module:dump())
    print(MultiDimensionalArray:dump())
    print(MultisetAsArray:dump())
    print(MultisetAsLinkedList:dump())
    print(Multiset:dump())
    print(MWayTree:dump())
    print(NaryTree:dump())
    print(Number:dump())
    print(Object:dump())
    print(OpenScatterTable:dump())
    print(OpenScatterTable.Entry:dump())
    print(OpenScatterTableV2:dump())
    print(Opus9:dump())
    print(OrderedListAsArray.Cursor:dump())
    print(OrderedListAsArray:dump())
    print(OrderedListAsLinkedList.Cursor:dump())
    print(OrderedListAsLinkedList:dump())
    print(OrderedList:dump())
    print(Parent:dump())
    print(PartitionAsForest:dump())
    print(PartitionAsForestV2:dump())
    print(PartitionAsForestV3:dump())
    print(Partition:dump())
    print(Person:dump())
    print(Point:dump())
    print(PolynomialAsOrderedList:dump())
    print(PolynomialAsSortedList:dump())
    print(Polynomial:dump())
    print(Polynomial.Term:dump())
    print(PriorityQueue:dump())
    print(QueueAsArray:dump())
    print(QueueAsLinkedList:dump())
    print(Queue:dump())
    print(QuickSorter:dump())
    print(RadixSorter:dump())
    print(RandomNumberGenerator:dump())
    print(RandomVariable:dump())
    print(Rectangle:dump())
    print(ScalesBalancingProblem:dump())
    print(ScalesBalancingProblem.Node:dump())
    print(SearchableContainer:dump())
    print(SearchTree:dump())
    print(SetAsArray:dump())
    print(SetAsBitVector:dump())
    print(Set:dump())
    print(SimpleRV:dump())
    print(Simulation:dump())
    print(Simulation.Event:dump())
    print(Solution:dump())
    print(Solver:dump())
    print(SortedListAsArray.Cursor:dump())
    print(SortedListAsArray:dump())
    print(SortedListAsLinkedList.Cursor:dump())
    print(SortedListAsLinkedList:dump())
    print(SortedList:dump())
    print(Sorter:dump())
    print(SparseMatrixAsArray:dump())
    print(SparseMatrixAsLinkedList:dump())
    print(SparseMatrixAsLinkedList.Entry:dump())
    print(SparseMatrixAsVector:dump())
    print(SparseMatrixAsVector.Entry:dump())
    print(SparseMatrix:dump())
    print(Square:dump())
    print(StackAsArray:dump())
    print(StackAsLinkedList:dump())
    print(Stack:dump())
    print(StraightInsertionSorter:dump())
    print(StraightSelectionSorter:dump())
    print(String:dump())
    print(Timer:dump())
    print(Tree:dump())
    print(TwoWayMergeSorter:dump())
    print(UniformRV:dump())
    print(Vertex:dump())
    print(ZeroOneKnapsackProblem:dump())
    print(ZeroOneKnapsackProblem.Node:dump())
end

if _REQUIREDNAME == nil then
    os.exit( Opus9.main(arg) )
end
