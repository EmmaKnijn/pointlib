-- optimisations
-- cache valid point hashes (tostring())

local pixelBoxURL = "https://raw.githubusercontent.com/9551-Dev/apis/main/pixelbox_lite.lua"
if not fs.exists("pixelbox.lua") then
  shell.run("wget " .. pixelBoxURL .. " pixelbox.lua")
end

local pixelbox = require("pixelbox")
local canvas = pixelbox.new(term.current())
local renderer = "pixelbox"
local displayBuffer = {}

term.clear()
term.setCursorPos(1,1)


local function PointCheck(p)
  if type(p) == "table" and p.type == "point" then
    return true
  else
    error("Point is not a valid point")
  end
end

local pointlib = {}

pointlib.createPoint = function(x,y)
  return {type="point",x=x,y=y}
end



pointlib.lerp = function(P1,P2,t)
  PointCheck(P1)
  PointCheck(P2)
  local x = (1-t) * P1.x + t * P2.x
  local y = (1-t) * P1.y + t * P2.y
  local point = pointlib.createPoint(x,y)
  return point
end

-- settings functions

pointlib.setRenderer = function(o)
  o = o or "pixelbox"
  if renderer == "pixelbox" or "term" then
    renderer = o
  end
end

-- draw functions
pointlib.draw = {}


pointlib.draw.point = function(p,color)
  PointCheck(p)
  color = color or colors.white
  table.insert(displayBuffer,{p.x,p.y})
  if renderer == "term" then
    local originalX, originalY = term.getCursorPos()
    term.setCursorPos(p.x,p.y)
    local oldColor = term.getTextColor()
    term.setTextColor(color)
    term.write("*")
    term.setTextColor(oldColor)
   term.setCursorPos(originalX,originalY)
  elseif renderer == "pixelbox" then
    canvas.CANVAS[math.floor(p.y)][math.floor(p.x)] = color
    canvas:render()
  end
end

pointlib.draw.line = function(P1,P2)  
  -- calculate the amount of points actually needed
  local diffX = P1.x - P2.x
  local diffY = P1.y - P2.y

  local length = math.sqrt(diffX^2+diffY^2)

  t = math.floor(length)
  --print(t)

  PointCheck(P1)
  PointCheck(P2)
  for i=0,t do
    local interPoint = pointlib.lerp(P1,P2, i * (1 / t))
    pointlib.draw.point(interPoint)
  end

end

return pointlib