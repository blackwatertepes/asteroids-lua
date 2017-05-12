AsteroidDrawSystem = class('AsteroidDrawSystem', System)

function AsteroidDrawSystem:draw()
  for i, entity in pairs(self.targets) do
    local comp = entity.components.Asteroid
    local x, y, size, rot, per = comp.x, comp.y, comp.size, comp.rot, comp.per
    love.graphics.push()
      love.graphics.translate(x + size / 2, y + size / 2)
      love.graphics.push()
        love.graphics.rotate(comp.rot)
        local theta = math.pi*2 * i/#comp.rands*2
        local x = size / 2 * per * comp.rands[0]
        local y = comp.rands[1]
        local lastXY = {x = x, y = y}
        for i=1, #comp.rands/2-1, 1 do
          local theta = math.pi*2 * i/#comp.rands*2
          local x = size / 2 * per * math.cos(theta) * comp.rands[i*2]
          local y = size / 2 * per * math.sin(theta) * comp.rands[i*2+1]
          love.graphics.line(x, y, lastXY.x, lastXY.y)
          lastXY.x = x
          lastXY.y = y
        end
        local theta = math.pi*2 * i/#comp.rands*2
        local x = size / 2 * per * comp.rands[0]
        local y = comp.rands[1]
        love.graphics.line(x, y, lastXY.x, lastXY.y)
      love.graphics.pop()
    love.graphics.pop()
    --love.graphics.rectangle('line', comp.x, comp.y, comp.size, comp.size) -- Bounding Box
  end
end

function AsteroidDrawSystem:requires()
  return {'Asteroid'}
end

return AsteroidDrawSystem
