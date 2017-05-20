DebrisDrawSystem = class('DebrisDrawSystem', System)

function DebrisDrawSystem:draw()
  for i, entity in pairs(self.targets) do
    local object, debris = entity.components.Object, entity.components.Debris
    local x, y, size, rot = object.x, object.y, debris.size, object.rotation
    love.graphics.push()
      love.graphics.translate(x, y)
      love.graphics.push()
        love.graphics.rotate(rot)
        love.graphics.line(-size / 2, 0, size / 2, 0)
      love.graphics.pop()
    love.graphics.pop()
  end
end

function DebrisDrawSystem:requires()
  return {'Debris'}
end

return DebrisDrawSystem
