DebrisDrawSystem = class('DebrisDrawSystem', System)

function DebrisDrawSystem:draw()
  for i, entity in pairs(self.targets) do
    local comp = entity.components.Debris
    local x, y, size, rot = comp.x, comp.y, comp.size, comp.rot
    love.graphics.push()
      love.graphics.translate(x + size / 2, y + size / 2)
      love.graphics.push()
        love.graphics.rotate(comp.rot)
        love.graphics.line(-size / 2, 0, size / 2, 0)
      love.graphics.pop()
    love.graphics.pop()
  end
end

function DebrisDrawSystem:requires()
  return {'Debris'}
end

return DebrisDrawSystem
