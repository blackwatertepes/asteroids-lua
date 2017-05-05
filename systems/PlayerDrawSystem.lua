PlayerDrawSystem = class('PlayerDrawSystem', System)

function PlayerDrawSystem:draw()
  for i, entity in pairs(self.targets) do
    local comp = entity.components.Player
    local x, y, size = comp.x, comp.y, comp.size
    love.graphics.push()
      love.graphics.translate(x + size / 2, y + size / 2)
      love.graphics.push()
        love.graphics.rotate(comp.rotation)
        love.graphics.rectangle('fill', -size / 2, -size / 2, size, size)
      love.graphics.pop()
    love.graphics.pop()
    --love.graphics.rectangle('line', comp.x, comp.y, comp.size, comp.size) -- Bounding Box
  end
end

function PlayerDrawSystem:requires()
  return {'Player'}
end

return PlayerDrawSystem
