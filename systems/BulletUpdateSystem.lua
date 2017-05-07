local BulletUpdateSystem = class("BulletUpdateSystem", System)
local Bullet, Asteroid, Debris = Component.load({'Bullet', 'Asteroid', 'Debris'})

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
        asteroid = col.other.components.Asteroid
        -- Create explosion debris
        for j=0, asteroid.size, 5 do
          local vector = math.random() * math.pi*2
          local x, y = asteroid.x + math.cos(vector) * asteroid.size, asteroid.y + math.sin(vector) * asteroid.size
          createEntity(Debris({size = math.random(10, 20), x = x, y = y, speed = 100, vector = vector}))
        end
        -- If it was a large asteroid, then create 2 smaller ones
        if asteroid.size > 50 then
          local size, speed = asteroid.size / 2 * math.random(50, 150) / 100, asteroid.speed
          local vectorA, vectorB = asteroid.vector + math.pi/2, asteroid.vector - math.pi/2
          local ax, ay = asteroid.x + math.cos(vectorA) * size * .8, asteroid.y + math.sin(vectorA) * size * .8
          local bx, by = asteroid.x + math.cos(vectorB) * size * .8, asteroid.y + math.sin(vectorB) * size * .8
          createWorldEntity(Asteroid({size = size, x = ax, y = ay, speed = speed, vector = asteroid.vector + math.random()}))
          createWorldEntity(Asteroid({size = size, x = bx, y = by, speed = speed, vector = asteroid.vector - math.random()}))
        end
      end
    end
  end
end

function BulletUpdateSystem:requires()
  return {'Bullet'}
end

return BulletUpdateSystem
