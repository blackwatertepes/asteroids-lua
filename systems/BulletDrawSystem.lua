BulletDrawSystem = class('BulletDrawSystem', System)

function BulletDrawSystem:draw()
  for i, entity in pairs(self.targets) do
    local comp = entity.components.Bullet
    local x, y, size = comp.x, comp.y, comp.size
    love.graphics.push()
      love.graphics.translate(x + size / 2, y + size / 2)
      love.graphics.push()
        love.graphics.rotate(comp.angle)
        love.graphics.line(0, 0, -5, 0)
      love.graphics.pop()
    love.graphics.pop()
    love.graphics.rectangle('line', comp.x, comp.y, comp.size, comp.size) -- Bounding Box
  end
end

function BulletDrawSystem:requires()
  return {'Bullet'}
end

return BulletDrawSystem
