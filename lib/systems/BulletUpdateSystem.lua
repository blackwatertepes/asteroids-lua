local BulletUpdateSystem = class("BulletUpdateSystem", System)
local Object, Bullet, Asteroid = Component.load({'Object', 'Bullet', 'Asteroid'})

function BulletUpdateSystem:update(dt)
  for i, entity in pairs(self.targets) do
    local object, comp = entity.components.Object, entity.components.Bullet
    -- Remove bullets that go off-screen
    if object.x < 0 or object.y < 0 or object.x > love.graphics.getWidth() or object.y > love.graphics.getHeight() then
      world:remove(entity)
      engine:removeEntity(entity)
    else
      goalX = object.x + object.speed * math.cos(object.vector) * dt
      goalY = object.y + object.speed * math.sin(object.vector) * dt
      -- Remove any asteroids that collide
      local filter = function(item, other)
        return other:get('Asteroid') and 'slide'
      end
      local actualX, actualY, cols, len = world:move(entity, goalX, goalY, filter)
      if len > 0 then
        world:remove(entity)
        engine:removeEntity(entity)
      else
        object.x = goalX
        object.y = goalY
      end

      for j, col in pairs(cols) do
        world:remove(col.other)
        engine:removeEntity(col.other)
        local obj, ast = col.other.components.Object, col.other.components.Asteroid
        ast:createDebris(obj)
        -- If it was a large asteroid, then create 2 smaller ones
        if obj.width > 50 then
          ast:createSmaller(obj)
        end
      end
    end
  end
end

function BulletUpdateSystem:requires()
  return {'Bullet'}
end

return BulletUpdateSystem
