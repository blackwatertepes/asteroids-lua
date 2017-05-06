AsteroidDrawSystem = class('AsteroidDrawSystem', System)

function AsteroidDrawSystem:draw()
  local per, jag = .7 -- percentage to bounding box
  for i, entity in pairs(self.targets) do
    local comp = entity.components.Asteroid
    local x, y, size, rot = comp.x, comp.y, comp.size, comp.rot
    love.graphics.push()
      love.graphics.translate(x + size / 2, y + size / 2)
      love.graphics.push()
        love.graphics.rotate(comp.rot)
        local lastXY = {x = comp.size * per * comp.rands[0], y = comp.rands[1]}
        for i=1, #comp.rands/2-1, 1 do
          local theta = math.pi*2 * i/#comp.rands*2
          x = comp.size * per * math.cos(theta) * comp.rands[i*2]
          y = comp.size * per * math.sin(theta) * comp.rands[i*2+1]
          love.graphics.line(lastXY.x, lastXY.y, x, y)
          lastXY.x = x
          lastXY.y = y
        end
        love.graphics.line(lastXY.x, lastXY.y, comp.size * per * comp.rands[0], comp.rands[1])
      love.graphics.pop()
    love.graphics.pop()
    --love.graphics.rectangle('line', comp.x, comp.y, comp.size, comp.size) -- Bounding Box
  end
end

function AsteroidDrawSystem:requires()
  return {'Asteroid'}
end

return AsteroidDrawSystem
