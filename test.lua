term.clear()
term.setCursorPos(1,1)

local pointlib = require("pointlib")
local P1 = pointlib.createPoint(5,2)
local P2 = pointlib.createPoint(20,40)



pointlib.draw.line(P1,P2)

local xSize, ySize = term.getSize()
term.setCursorPos(1,ySize)