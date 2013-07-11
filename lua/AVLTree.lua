#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: AVLTree.lua,v $
    $Revision: 1.4 $

    $Id: AVLTree.lua,v 1.4 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "BinarySearchTree"

--{
-- An Adelson-Velskii and Landis binary search tree.
AVLTree = Class.new("AVLTree", BinarySearchTree)

-- Constructor.
function AVLTree.methods:initialize()
    AVLTree.super(self)
    self.height = -1
end

-- The key in this AVL tree node.
AVLTree:attr_accessor("key")

-- The left subtree of this AVL tree node.
AVLTree:attr_accessor("left")

-- The right subtree of this AVL tree node.
AVLTree:attr_accessor("right")
--}>a

--{
-- The height of this AVL tree node.
AVLTree:attr_reader("height")

-- Adjusts the height of this tree node.
function AVLTree.methods:adjustHeight()
    if self:is_empty() then
	self.height = -1
    else
	self.height =
	    math.max(self.left.height, self.right.height) + 1
    end
end

-- The balance factor of this tree node.
function AVLTree.methods:get_balanceFactor()
    if self:is_empty() then
	return 0
    else
	return self.left.height - self.right.height
    end
end
--}>b

--{
-- Does an LL rotation at this AVL tree node.
function AVLTree.methods:doLLRotation()
    if self:is_empty() then
	error "StateError"
    end
    local tmp = self.right
    self.right = self.left
    self.left = self.right.left
    self.right.left = self.right.right
    self.right.right = tmp

    tmp = self.key
    self.key = self.right.key
    self.right.key = tmp

    self.right:adjustHeight()
    self:adjustHeight()
end
--}>c
--++

--{
-- Does an LR rotation at this AVL tree node.
function AVLTree.methods:doLRRotation()
    if self:is_empty() then
	error "StateError"
    end
    self.left:doRRRotation()
    self:doLLRotation()
end
--}>d

--{
--++
-- Balances this AVL tree.
function AVLTree.methods:balance()
    self:adjustHeight()
    if self:get_balanceFactor() > 1 then
	if self.left:get_balanceFactor() > 0 then
	    self:doLLRotation()
	else
	    self:doLRRotation()
	end
    elseif self:get_balanceFactor() < -1 then
	if self.right:get_balanceFactor() < 0 then
	    self:doRRRotation()
	else
	    self:doRLRotation()
	end
    end
end
--}>e

--{
-- Attaches the given key to this AVL tree node.
-- @param obj The key to attached.
function AVLTree.methods:attachKey(obj)
    if not self:is_empty() then
	error "StateError"
    end
    self.key = obj
    self.left = AVLTree.new()
    self.right = AVLTree.new()
    self.height = 0
end
--}>f

--{
-- Detaches the key from this AVL tree node.
function AVLTree.methods:detachKey()
    BinaryTree.methods.detachKey(self)
    self.height = -1
end
--}>g

-- Does an RR rotation at this AVL tree node.
function AVLTree.methods:doRRRotation()
    if self:is_empty() then
	error "StateError"
    end
    local tmp = self.left
    self.left = self.right
    self.right = self.left.right
    self.left.right = self.left.left
    self.left.left = tmp

    tmp = self.key
    self.key = self.left.key
    self.left.key = tmp

    self.left:adjustHeight()
    self:adjustHeight()
end

-- Does an RL rotation at this AVL tree node.
function AVLTree.methods:doRLRotation()
    if self:is_empty() then
	error "StateError"
    end
    self.right:doLLRotation()
    self:doRRRotation()
end

-- AVLTree test program.
-- @param arg Command-line arguments.
function AVLTree.main(arg)
    print "AVLTree test program."
    print(AVLTree)
    local tree = AVLTree.new()
    SearchTree.test(tree)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( AVLTree.main(arg) )
end
