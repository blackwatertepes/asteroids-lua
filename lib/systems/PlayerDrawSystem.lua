PlayerDrawSystem = class('PlayerDrawSystem', System)

function PlayerDrawSystem:draw()
  local cannonPer, frontPer, backPer, finPer, lenPer = 0.1, 0.8, 1.2, 0.1, 1.4
  for i, entity in pairs(self.targets) do
    local comp = entity.components.Player
    local x, y, size = comp.x, comp.y, comp.size
    love.graphics.push()
      love.graphics.translate(x + size / 2, y + size / 2)
      love.graphics.push()
        love.graphics.rotate(comp.rotation)
        local c, f, b, fi, l = cannonPer * comp.size, frontPer * comp.size, backPer * comp.size, finPer * comp.size, lenPer * comp.size
        love.graphics.polygon('line', 0, 0, c, c, l/2, c, l/2, f/2, -l/2, b/2, -l/2, b/4, -l/2+fi, b/4, -l/2+fi, -b/4, -l/2, -b/4, -l/2, -b/2, l/2, -f/2, l/2, -c, c, -c)

        if comp.highlight then
          love.graphics.setColor(255, 255, 255, 50)
          love.graphics.circle('fill', 0, 0, size * 2, 50)
          love.graphics.reset()
        end
      love.graphics.pop()
    love.graphics.pop()
    --love.graphics.rectangle('line', comp.x, comp.y, comp.size, comp.size) -- Bounding Box
  end
end

function PlayerDrawSystem:requires()
  return {'Player'}
end

return PlayerDrawSystem
