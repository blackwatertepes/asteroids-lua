PlayerDrawSystem = class('PlayerDrawSystem', System)

function PlayerDrawSystem:draw()
  for i, entity in pairs(self.targets) do
    local x, y, size = entity:get('Player').x, entity:get('Player').y, entity:get('Player').size
    love.graphics.rectangle('fill', x, y, size, size)
  end
end

function PlayerDrawSystem:requires()
  return {'Player'}
end

return PlayerDrawSystem
