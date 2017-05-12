local BulletUpdateSystem = class("BulletUpdateSystem", System)
local Bullet, Asteroid = Component.load({'Bullet', 'Asteroid'})

function BulletUpdateSystem:update(dt)
  local speed = 500
  for i, entity in pairs(self.targets) do
    local comp = entity.components.Bullet
    -- Remove bullets that go off-screen
    if comp.x < 0 or comp.y < 0 or comp.x > love.graphics.getWidth() or comp.y > love.graphics.getHeight() then
      world:remove(entity)
      engine:removeEntity(entity)
    else
      goalX = comp.x + speed * math.cos(comp.angle) * dt
      goalY = comp.y + speed * math.sin(comp.angle) * dt
      -- Remove any asteroids that collide
      local filter = function(item, other)
        return other:get('Asteroid') and 'slide'
      end
      local actualX, actualY, cols, len = world:move(entity, goalX, goalY, filter)
      if len > 0 then
        world:remove(entity)
        engine:removeEntity(entity)
      else
        comp.x = goalX
        comp.y = goalY
      end

      for j, col in pairs(cols) do
        world:remove(col.other)
        engine:removeEntity(col.other)
        comp = col.other.components.Asteroid
        comp:createDebris()
        -- If it was a large asteroid, then create 2 smaller ones
        if comp.size > 50 then
          comp:createSmaller()
        end
      end
    end
  end
end

function BulletUpdateSystem:requires()
  return {'Bullet'}
end

return BulletUpdateSystem
