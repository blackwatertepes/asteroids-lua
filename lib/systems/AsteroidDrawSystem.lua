AsteroidDrawSystem = class('AsteroidDrawSystem', System)

function AsteroidDrawSystem:draw()
  for i, entity in pairs(self.targets) do
    local object, asteroid = entity.components.Object, entity.components.Asteroid
    local x, y, size, rot, per = object.x, object.y, object.width, object.rotation, asteroid.per
    love.graphics.push()
      love.graphics.translate(x + size / 2, y + size / 2)
      love.graphics.push()
        love.graphics.rotate(rot)
        local theta = math.pi*2 * i/#asteroid.rands*2
        local x = size / 2 * per * asteroid.rands[0]
        local y = asteroid.rands[1]
        local lastXY = {x = x, y = y}
        for i=1, #asteroid.rands/2-1, 1 do
          local theta = math.pi*2 * i/#asteroid.rands*2
          local x = size / 2 * per * math.cos(theta) * asteroid.rands[i*2]
          local y = size / 2 * per * math.sin(theta) * asteroid.rands[i*2+1]
          love.graphics.line(x, y, lastXY.x, lastXY.y)
          lastXY.x = x
          lastXY.y = y
        end
        local theta = math.pi*2 * i/#asteroid.rands*2
        local x = size / 2 * per * asteroid.rands[0]
        local y = asteroid.rands[1]
        love.graphics.line(x, y, lastXY.x, lastXY.y)
      love.graphics.pop()
    love.graphics.pop()
    love.graphics.rectangle('line', object.x, object.y, object.width, object.height) -- Bounding Box
  end
end

function AsteroidDrawSystem:requires()
  return {'Asteroid'}
end

return AsteroidDrawSystem
