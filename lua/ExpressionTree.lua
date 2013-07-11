#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/02 01:13:45 $
    $RCSfile: ExpressionTree.lua,v $
    $Revision: 1.1 $

    $Id: ExpressionTree.lua,v 1.1 2004/12/02 01:13:45 brpreiss Exp $

--]]

require "BinaryTree"
require "StackAsLinkedList"

--{
-- Represents an expression comprised of binary operators and operands.
ExpressionTree = Class.new("ExpressionTree", BinaryTree)

-- Constructs an expression tree node
-- that contains the given word (operand).
-- @param word A word.
function ExpressionTree.methods:initialize(word)
    ExpressionTree.super(self, word)
end

-- Parses the input stream into an expression tree.
-- The input is assumed to be a blank-separated postfix expression.
-- @param input Input stream.
function ExpressionTree.parsePostfix(input)
    local stack = StackAsLinkedList.new()
    for line in input:lines() do
	for word in string.gfind(line, "%S+") do
	    if word == "+" or word == "-"
		or word == "*" or word == "/" then
		local result = ExpressionTree.new(box(word))
		result:attachRight(stack:pop())
		result:attachLeft(stack:pop())
		stack:push(result)
	    else
		stack:push(ExpressionTree.new(box(word)))
	    end
	end
    end
    return stack:pop()
end
--}>a

--{
-- Returns a string representation of this binary expression tree.
function ExpressionTree.methods:toString()
    local s = ""
    self:depthFirstTraversal(
	function(obj, mode)
	    if mode == Tree.PREVISIT then
		s = s .. "("
	    elseif mode == Tree.INVISIT then
		s = s .. tostring(obj)
	    elseif mode == Tree.POSTVISIT then
		s = s .. ")"
	    end
	end
    )
    return s
end
--}>b
