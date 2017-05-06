local AsteroidUpdateSystem = class('AsteroidUpdateSystem', System)

function AsteroidUpdateSystem:update(dt)
  for i, entity in pairs(self.targets) do
    local comp = entity.components.Asteroid
    goalX = comp.x + (comp.stepX * dt)
    goalY = comp.y + (comp.stepY * dt)
    comp.rot = comp.rot + (comp.stepRot * dt)
    local actualX, actualY, cols, len = world:move(entity, goalX, goalY)
    if len == 0 then
      comp.x = actualX
      comp.y = actualY
    else
      world:remove(entity)
      engine:removeEntity(entity)

      for k, col in pairs(cols) do
        if col.other:get('Asteroid') then
          world:remove(col.other)
          engine:removeEntity(col.other)
        end
      end
    end
    -- Remove asteroids that are farther away than the spawn point
    if math.sqrt(math.pow(comp.x, 2) + math.pow(comp.y, 2)) > comp.dist * 2 then
      world:remove(entity)
      engine:removeEntity(entity)
    end
  end
end

function AsteroidUpdateSystem:requires()
  return {'Asteroid'}
end

return AsteroidUpdateSystem
