PlayerDrawSystem = class('PlayerDrawSystem', System)

function PlayerDrawSystem:draw()
  for i, entity in pairs(self.targets) do
    local x, y, size = entity:get('Player').x, entity:get('Player').y, entity:get('Player').size
    love.graphics.push()
      love.graphics.translate(x + size / 2, y + size / 2)
      love.graphics.push()
        love.graphics.rotate(30)
        love.graphics.rectangle('fill', -size / 2, -size / 2, size, size)
      love.graphics.pop()
    love.graphics.pop()
  end
end

function PlayerDrawSystem:requires()
  return {'Player'}
end

return PlayerDrawSystem
