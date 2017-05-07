local AsteroidUpdateSystem = class('AsteroidUpdateSystem', System)
local Debris = Component.load({'Debris'})

function AsteroidUpdateSystem:update(dt)
  for i, entity in pairs(self.targets) do
    local comp = entity.components.Asteroid
    -- Remove asteroids that are farther away than the spawn point
    if math.sqrt(math.pow(comp.x, 2) + math.pow(comp.y, 2)) > love.graphics.getWidth() * 3 then
      world:remove(entity)
      engine:removeEntity(entity)
    else
      goalX = comp.x + (comp.stepX * dt)
      goalY = comp.y + (comp.stepY * dt)
      local filter = function(item, other)
        return other:get('Asteroid') and 'slide'
      end
      local actualX, actualY, cols, len = world:move(entity, goalX, goalY, filter)
      if len == 0 then
        comp.rot = comp.rot + (comp.stepRot * dt)
        comp.x = actualX
        comp.y = actualY
      else
        world:remove(entity)
        engine:removeEntity(entity)
        -- Create explosion debris
        for j=0, comp.size, 5 do
          local vector = math.random() * math.pi*2
          local x, y = comp.x + math.cos(vector) * comp.size, comp.y + math.sin(vector) * comp.size
          createEntity(Debris({size = math.random(10, 20), x = x, y = y, speed = 100, vector = vector}))
        end
        for k, col in pairs(cols) do
          world:remove(col.other)
          engine:removeEntity(col.other)
          local comp = col.other.components.Asteroid
          -- Create explosion debris
          for j=0, comp.size, 5 do
            local vector = math.random() * math.pi*2
            local x, y = comp.x + math.cos(vector) * comp.size, comp.y + math.sin(vector) * comp.size
            createEntity(Debris({size = math.random(10, 20), x = x, y = y, speed = 100, vector = vector}))
          end
        end
      end
    end
  end
end

function AsteroidUpdateSystem:requires()
  return {'Asteroid'}
end

return AsteroidUpdateSystem
