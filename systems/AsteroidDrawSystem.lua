AsteroidDrawSystem = class('AsteroidDrawSystem', System)

function AsteroidDrawSystem:draw()
  for i, entity in pairs(self.targets) do
    local comp = entity.components.Asteroid
    local x, y, size, rot = comp.x, comp.y, comp.size, comp.rot
    love.graphics.push()
      love.graphics.translate(x + size / 2, y + size / 2)
      love.graphics.push()
        love.graphics.rotate(comp.rot)
        love.graphics.rectangle('fill', -size / 2, -size / 2, size, size)
        love.graphics.push()
          love.graphics.rotate(1)
          love.graphics.rectangle('fill', -size / 2, -size / 2, size, size)
        love.graphics.pop()
      love.graphics.pop()
    love.graphics.pop()
    --love.graphics.rectangle('line', comp.x, comp.y, comp.size, comp.size) -- Bounding Box
  end
end

function AsteroidDrawSystem:requires()
  return {'Asteroid'}
end

return AsteroidDrawSystem
