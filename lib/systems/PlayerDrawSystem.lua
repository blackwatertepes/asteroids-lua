PlayerDrawSystem = class('PlayerDrawSystem', System)

function PlayerDrawSystem:draw()
  local cannonPer, frontPer, backPer, finPer, lenPer = 0.1, 0.8, 1.2, 0.1, 1.4
  for i, entity in pairs(self.targets) do
    local object, comp = entity.components.Object, entity.components.Player
    local x, y, size, rotation = object.x, object.y, object.width, object.rotation
    love.graphics.push()
      love.graphics.translate(x + size / 2, y + size / 2)
      love.graphics.push()
        love.graphics.rotate(rotation)
        local c, f, b, fi, l = cannonPer * size, frontPer * size, backPer * size, finPer * size, lenPer * size
        love.graphics.polygon('line', 0, 0, c, c, l/2, c, l/2, f/2, -l/2, b/2, -l/2, b/4, -l/2+fi, b/4, -l/2+fi, -b/4, -l/2, -b/4, -l/2, -b/2, l/2, -f/2, l/2, -c, c, -c)

        if comp.highlight then
          love.graphics.setColor(255, 255, 255, 50)
          love.graphics.circle('fill', 0, 0, size * 2, 50)
          love.graphics.reset()
        end
      love.graphics.pop()
    love.graphics.pop()
    --love.graphics.rectangle('line', object.x, object.y, object.width, object.height) -- Bounding Box
  end
end

function PlayerDrawSystem:requires()
  return {'Player'}
end

return PlayerDrawSystem
