local BulletUpdateSystem = class("BulletUpdateSystem", System)
local Bullet, Asteroid = Component.load({'Bullet', 'Asteroid'})

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
    if len > 0 then
      world:remove(entity)
      engine:removeEntity(entity)
    end

    for j, col in pairs(cols) do
      world:remove(col.other)
      engine:removeEntity(col.other)
      -- If it was a large asteroid, then create 2 smaller ones
      asteroid = col.other.components.Asteroid
      if asteroid.size > 50 then
        local size, speed = asteroid.size / 2, asteroid.speed
        local vectorA, vectorB = asteroid.vector + math.pi/2, asteroid.vector - math.pi/2
        local ax, ay = asteroid.x + math.cos(vectorA) * size * .8, asteroid.y + math.sin(vectorA) * size * .8
        local bx, by = asteroid.x + math.cos(vectorB) * size * .8, asteroid.y + math.sin(vectorB) * size * .8
        createEntity(Asteroid({size = size, x = ax, y = ay, speed = speed, vector = asteroid.vector + math.random()}))
        createEntity(Asteroid({size = size, x = bx, y = by, speed = speed, vector = asteroid.vector - math.random()}))
      end
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
