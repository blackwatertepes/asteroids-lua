AsteroidDrawSystem = class('AsteroidDrawSystem', System)

function AsteroidDrawSystem:draw()
  for i, entity in pairs(self.targets) do
    local x, y, size = entity:get('Asteroid').x, entity:get('Asteroid').y, entity:get('Asteroid').size
    love.graphics.rectangle('fill', x, y, size, size)
  end
end

function AsteroidDrawSystem:requires()
  return {'Asteroid'}
end

return AsteroidDrawSystem
