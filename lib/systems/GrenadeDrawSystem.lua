GrenadeDrawSystem = class('GrenadeDrawSystem', System)

function GrenadeDrawSystem:draw()
  for i, entity in pairs(self.targets) do
    local comp = entity.components.Grenade
    love.graphics.push()
      love.graphics.translate(comp.x + comp.size / 2, comp.y + comp.size / 2)
      love.graphics.push()
        love.graphics.rotate(comp.angle)
        love.graphics.rectangle('line', -comp.size / 2, -comp.size / 2, comp.size / 2, comp.size / 2)
        love.graphics.line(0, 0, -5, 0)
      love.graphics.pop()
    love.graphics.pop()
    --love.graphics.rectangle('line', comp.x, comp.y, comp.size, comp.size) -- Bounding Box
  end
end

function GrenadeDrawSystem:requires()
  return {'Grenade'}
end

return GrenadeDrawSystem
