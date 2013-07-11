#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 21:35:57 $
#   $RCSfile: Opus10.pm,v $
#   $Revision: 1.1 $
#
#   $Id: Opus10.pm,v 1.1 2005/09/25 21:35:57 brpreiss Exp $
#

use strict;

# @package Opus10
# The Opus10 package.
package Opus10;
use Opus10::Algorithms;
use Opus10::Application11;
use Opus10::Application12;
use Opus10::Application1;
use Opus10::Application2;
use Opus10::Application3;
use Opus10::Application4;
use Opus10::Application5;
use Opus10::Application6;
use Opus10::Application7;
use Opus10::Application8;
use Opus10::Application9;
use Opus10::Array;
use Opus10::Association;
use Opus10::AVLTree;
use Opus10::BinaryHeap;
use Opus10::BinaryInsertionSorter;
use Opus10::BinarySearchTree;
use Opus10::BinaryTree;
use Opus10::BinomialQueue;
use Opus10::Box;
use Opus10::BreadthFirstBranchAndBoundSolver;
use Opus10::BreadthFirstSolver;
use Opus10::BTree;
use Opus10::BubbleSorter;
use Opus10::BucketSorter;
use Opus10::ChainedHashTable;
use Opus10::ChainedScatterTable;
use Opus10::Circle;
use Opus10::Comparable;
use Opus10::Complex;
use Opus10::Container;
use Opus10::Cursor;
use Opus10::Deap;
use Opus10::Declarators;
use Opus10::Demo10;
use Opus10::Demo1;
use Opus10::Demo2;
use Opus10::Demo3;
use Opus10::Demo4;
use Opus10::Demo5;
use Opus10::Demo6;
use Opus10::Demo7;
use Opus10::Demo9;
use Opus10::DenseMatrix;
use Opus10::DepthFirstBranchAndBoundSolver;
use Opus10::DepthFirstSolver;
use Opus10::DequeAsArray;
use Opus10::DequeAsLinkedList;
use Opus10::Deque;
use Opus10::DigraphAsLists;
use Opus10::DigraphAsMatrix;
use Opus10::Digraph;
use Opus10::DoubleEndedPriorityQueue;
use Opus10::Edge;
use Opus10::Example;
use Opus10::Experiment1;
use Opus10::Experiment2;
use Opus10::ExponentialRV;
use Opus10::ExpressionTree;
use Opus10::Float;
use Opus10::GeneralTree;
use Opus10::GraphAsLists;
use Opus10::GraphAsMatrix;
use Opus10::GraphicalObject;
use Opus10::Graph;
use Opus10::HashTable;
use Opus10::HeapSorter;
use Opus10::Integer;
use Opus10::LeftistHeap;
use Opus10::LinkedList;
use Opus10::Matrix;
use Opus10::MedianOfThreeQuickSorter;
use Opus10::MergeablePriorityQueue;
use Opus10::MultiDimensionalArray;
use Opus10::MultisetAsArray;
use Opus10::MultisetAsLinkedList;
use Opus10::Multiset;
use Opus10::MWayTree;
use Opus10::NaryTree;
use Opus10::Object;
use Opus10::OpenScatterTable;
use Opus10::OpenScatterTableV2;
use Opus10::OrderedListAsArray;
use Opus10::OrderedListAsLinkedList;
use Opus10::OrderedList;
use Opus10::Parent;
use Opus10::PartitionAsForest;
use Opus10::PartitionAsForestV2;
use Opus10::PartitionAsForestV3;
use Opus10::Partition;
use Opus10::Person;
use Opus10::Point;
use Opus10::PolynomialAsOrderedList;
use Opus10::PolynomialAsSortedList;
use Opus10::Polynomial;
use Opus10::PriorityQueue;
use Opus10::QueueAsArray;
use Opus10::QueueAsLinkedList;
use Opus10::Queue;
use Opus10::QuickSorter;
use Opus10::RadixSorter;
use Opus10::RandomNumberGenerator;
use Opus10::RandomVariable;
use Opus10::Rectangle;
use Opus10::ScalesBalancingProblem;
use Opus10::SearchableContainer;
use Opus10::SearchTree;
use Opus10::SetAsArray;
use Opus10::SetAsBitVector;
use Opus10::Set;
use Opus10::SimpleRV;
use Opus10::Simulation;
use Opus10::Solution;
use Opus10::Solver;
use Opus10::SortedListAsArray;
use Opus10::SortedListAsLinkedList;
use Opus10::SortedList;
use Opus10::Sorter;
use Opus10::SparseMatrixAsArray;
use Opus10::SparseMatrixAsLinkedList;
use Opus10::SparseMatrixAsVector;
use Opus10::SparseMatrix;
use Opus10::Square;
use Opus10::StackAsArray;
use Opus10::StackAsLinkedList;
use Opus10::Stack;
use Opus10::StraightInsertionSorter;
use Opus10::StraightSelectionSorter;
use Opus10::String;
use Opus10::Timer;
use Opus10::Tree;
use Opus10::TwoWayMergeSorter;
use Opus10::UniformRV;
use Opus10::Vertex;
use Opus10::Wrapper;
use Opus10::ZeroOneKnapsackProblem;

our $VERSION = 1.00;

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my (@args) = @_;
    my $status = 0;
    #Opus10::Algorithms->dump();
    #Opus10::Application11->dump();
    #Opus10::Application12->dump();
    #Opus10::Application1->dump();
    #Opus10::Application2->dump();
    #Opus10::Application3->dump();
    #Opus10::Application4->dump();
    #Opus10::Application5->dump();
    #Opus10::Application6->dump();
    #Opus10::Application7->dump();
    #Opus10::Application8->dump();
    #Opus10::Application9->dump();
    Opus10::Array->dump();
    Opus10::Association->dump();
    Opus10::AVLTree->dump();
    Opus10::BinaryHeap->dump();
    Opus10::BinaryInsertionSorter->dump();
    Opus10::BinarySearchTree->dump();
    Opus10::BinaryTree->dump();
    Opus10::BinomialQueue->dump();
    #Opus10::Box->dump();
    Opus10::BreadthFirstBranchAndBoundSolver->dump();
    Opus10::BreadthFirstSolver->dump();
    Opus10::BTree->dump();
    Opus10::BubbleSorter->dump();
    Opus10::BucketSorter->dump();
    Opus10::ChainedHashTable->dump();
    Opus10::ChainedScatterTable->dump();
    Opus10::Circle->dump();
    Opus10::Comparable->dump();
    Opus10::Complex->dump();
    Opus10::Container->dump();
    Opus10::Cursor->dump();
    Opus10::Deap->dump();
    #Opus10::Declarators->dump();
    #Opus10::Demo10->dump();
    #Opus10::Demo1->dump();
    #Opus10::Demo2->dump();
    #Opus10::Demo3->dump();
    #Opus10::Demo4->dump();
    #Opus10::Demo5->dump();
    #Opus10::Demo6->dump();
    #Opus10::Demo7->dump();
    #Opus10::Demo9->dump();
    Opus10::DenseMatrix->dump();
    Opus10::DepthFirstBranchAndBoundSolver->dump();
    Opus10::DepthFirstSolver->dump();
    Opus10::DequeAsArray->dump();
    Opus10::DequeAsLinkedList->dump();
    Opus10::Deque->dump();
    Opus10::DigraphAsLists->dump();
    Opus10::DigraphAsMatrix->dump();
    Opus10::Digraph->dump();
    Opus10::DoubleEndedPriorityQueue->dump();
    Opus10::Edge->dump();
    #Opus10::Example->dump();
    #Opus10::Experiment1->dump();
    #Opus10::Experiment2->dump();
    Opus10::ExponentialRV->dump();
    Opus10::ExpressionTree->dump();
    Opus10::Float->dump();
    Opus10::GeneralTree->dump();
    Opus10::GraphAsLists->dump();
    Opus10::GraphAsMatrix->dump();
    Opus10::GraphicalObject->dump();
    Opus10::Graph->dump();
    Opus10::HashTable->dump();
    Opus10::HeapSorter->dump();
    Opus10::Integer->dump();
    Opus10::LeftistHeap->dump();
    Opus10::LinkedList->dump();
    Opus10::Matrix->dump();
    Opus10::MedianOfThreeQuickSorter->dump();
    Opus10::MergeablePriorityQueue->dump();
    Opus10::MultiDimensionalArray->dump();
    Opus10::MultisetAsArray->dump();
    Opus10::MultisetAsLinkedList->dump();
    Opus10::Multiset->dump();
    Opus10::MWayTree->dump();
    Opus10::NaryTree->dump();
    Opus10::Object->dump();
    Opus10::OpenScatterTable->dump();
    Opus10::OpenScatterTableV2->dump();
    Opus10::OrderedListAsArray->dump();
    Opus10::OrderedListAsLinkedList->dump();
    Opus10::OrderedList->dump();
    Opus10::Parent->dump();
    Opus10::PartitionAsForest->dump();
    Opus10::PartitionAsForestV2->dump();
    Opus10::PartitionAsForestV3->dump();
    Opus10::Partition->dump();
    Opus10::Person->dump();
    Opus10::Point->dump();
    Opus10::PolynomialAsOrderedList->dump();
    Opus10::PolynomialAsSortedList->dump();
    Opus10::Polynomial->dump();
    Opus10::PriorityQueue->dump();
    Opus10::QueueAsArray->dump();
    Opus10::QueueAsLinkedList->dump();
    Opus10::Queue->dump();
    Opus10::QuickSorter->dump();
    Opus10::RadixSorter->dump();
    Opus10::RandomNumberGenerator->dump();
    Opus10::RandomVariable->dump();
    Opus10::Rectangle->dump();
    Opus10::ScalesBalancingProblem->dump();
    Opus10::SearchableContainer->dump();
    Opus10::SearchTree->dump();
    Opus10::SetAsArray->dump();
    Opus10::SetAsBitVector->dump();
    Opus10::Set->dump();
    Opus10::SimpleRV->dump();
    Opus10::Simulation->dump();
    Opus10::Solution->dump();
    Opus10::Solver->dump();
    Opus10::SortedListAsArray->dump();
    Opus10::SortedListAsLinkedList->dump();
    Opus10::SortedList->dump();
    Opus10::Sorter->dump();
    Opus10::SparseMatrixAsArray->dump();
    Opus10::SparseMatrixAsLinkedList->dump();
    Opus10::SparseMatrixAsVector->dump();
    Opus10::SparseMatrix->dump();
    Opus10::Square->dump();
    Opus10::StackAsArray->dump();
    Opus10::StackAsLinkedList->dump();
    Opus10::Stack->dump();
    Opus10::StraightInsertionSorter->dump();
    Opus10::StraightSelectionSorter->dump();
    Opus10::String->dump();
    Opus10::Timer->dump();
    Opus10::Tree->dump();
    Opus10::TwoWayMergeSorter->dump();
    Opus10::UniformRV->dump();
    Opus10::Vertex->dump();
    Opus10::Wrapper->dump();
    Opus10::ZeroOneKnapsackProblem->dump();
    return $status;
}

use Cwd 'abs_path';
if (abs_path($0) eq abs_path(__FILE__))
{
    no strict 'refs';
    exit &{__PACKAGE__ . '::main'}(@ARGV);
}

1;
__DATA__

=head1 MODULE C<Opus10>

=head2 PACKAGE C<Opus10>

The Opus10 package.

=head3 FUNCTION C<main>

Main program.

=head4 Parameters

=over

=item C<args>

Command-line arguments.

=back

=head4 Return

Zero on success; non-zero on failure.

=cut

