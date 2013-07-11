#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/02 01:13:45 $
    $RCSfile: Application6.lua,v $
    $Revision: 1.1 $

    $Id: Application6.lua,v 1.1 2004/12/02 01:13:45 brpreiss Exp $

--]]

require "ExpressionTree"

-- Provides application program number 6.
Application6 = Module.new("Application6")

-- Application program number 6.
-- @param arg Command-line arguments.
function Application6.main(arg)
    print "Application program number 6. (expression tree)"
    local expression = ExpressionTree.parsePostfix(io.stdin)
    print(expression)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( Application6.main(arg) )
end
