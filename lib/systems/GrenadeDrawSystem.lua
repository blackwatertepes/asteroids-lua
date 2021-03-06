GrenadeDrawSystem = class('GrenadeDrawSystem', System)

function GrenadeDrawSystem:draw()
  for i, entity in pairs(self.targets) do
    local object, comp = entity.components.Object, entity.components.Grenade
    love.graphics.push()
      love.graphics.translate(object.x + object.width / 2, object.y + object.height / 2)
      love.graphics.push()
        love.graphics.rotate(object.rotation)
        love.graphics.rectangle('line', -object.width / 2, -object.height / 2, object.width, object.height)
        love.graphics.line(0, 0, -5, 0)
      love.graphics.pop()
    love.graphics.pop()
    --love.graphics.rectangle('line', object.x, object.y, object.width, object.height) -- Bounding Box
  end
end

function GrenadeDrawSystem:requires()
  return {'Grenade'}
end

return GrenadeDrawSystem
