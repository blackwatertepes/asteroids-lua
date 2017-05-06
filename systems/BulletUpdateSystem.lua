local BulletUpdateSystem = class("BulletUpdateSystem", System)
local Bullet = Component.load({'Bullet'})

function BulletUpdateSystem:update(dt)
  local speed = 500
  for i, entity in pairs(self.targets) do
    local comp = entity.components.Bullet
    goalX = comp.x + speed * math.cos(comp.angle) * dt
    goalY = comp.y + speed * math.sin(comp.angle) * dt
    -- Remove any asteroids that collide
    local filter = function(item, other)
      return other:get('Asteroid') and 'slide'
    end
    local actualX, actualY, cols, len = world:move(entity, goalX, goalY, filter)
    for j, col in pairs(cols) do
      world:remove(col.other)
      engine:removeEntity(col.other)
    end
    comp.x = goalX
    comp.y = goalY
    -- Remove bullets that go off-screen
    if comp.x < 0 or comp.y < 0 or comp.x > love.graphics.getWidth() or comp.y > love.graphics.getHeight() then
      world:remove(entity)
      engine:removeEntity(entity)
    end
  end
end

function BulletUpdateSystem:requires()
  return {'Bullet'}
end

return BulletUpdateSystem
