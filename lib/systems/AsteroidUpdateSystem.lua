local AsteroidUpdateSystem = class('AsteroidUpdateSystem', System)
local Debris = Component.load({'Debris'})

function AsteroidUpdateSystem:update(dt)
  for i, entity in pairs(self.targets) do
    local object, asteroid = entity.components.Object, entity.components.Asteroid
    -- Remove asteroids that are farther away than the spawn point
    if math.sqrt(math.pow(object.x, 2) + math.pow(object.y, 2)) > love.graphics.getWidth() * 3 then
      world:remove(entity)
      engine:removeEntity(entity)
    else
      goalX = object.x + (object.stepX * dt)
      goalY = object.y + (object.stepY * dt)
      local filter = function(item, other)
        return other:get('Asteroid') and 'slide'
      end
      local actualX, actualY, cols, len = world:move(entity, goalX, goalY, filter)
      if len == 0 then
        object.rotation = object.rotation + (object.stepRot * dt)
        object.x = actualX
        object.y = actualY
      else
        world:remove(entity)
        engine:removeEntity(entity)
        asteroid:createDebris(object)

        for k, col in pairs(cols) do
          world:remove(col.other)
          engine:removeEntity(col.other)
          local obj, ast = col.other.components.Object, col.other.components.Asteroid
          ast:createDebris(obj)
        end
      end
    end
  end
end

function AsteroidUpdateSystem:requires()
  return {'Asteroid'}
end

return AsteroidUpdateSystem
