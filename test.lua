
local pointlib = require("pointlib")
-- first line
local P1 = pointlib.createPoint(5,2)
local P2 = pointlib.createPoint(20,40)
pointlib.draw.line(P1,P2)
pointlib.setRenderer("term")
pointlib.render()