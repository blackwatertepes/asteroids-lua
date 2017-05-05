AsteroidDrawSystem = class('AsteroidDrawSystem', System)

function AsteroidDrawSystem:draw()
  for i, entity in pairs(self.targets) do
    local x, y, size = entity:get('Ast').x, entity:get('Ast').y, entity:get('Ast').size
    love.graphics.rectangle('fill', x, y, size, size)
  end
end

function AsteroidDrawSystem:requires()
  return {'Ast'}
end

return AsteroidDrawSystem
