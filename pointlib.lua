-- optimisations
-- cache valid point hashes (tostring())
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


-- draw functions
pointlib.draw = {}

pointlib.draw.point = function(p)
  PointCheck(p)
  local originalX, originalY = term.getCursorPos()
  term.setCursorPos(p.x,p.y)
  term.write("*")
  term.setCursorPos(originalX,originalY)
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