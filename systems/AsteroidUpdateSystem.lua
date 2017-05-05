local AsteroidUpdateSystem = class('AsteroidUpdateSystem', System)

function AsteroidUpdateSystem:update(dt)
  for i, entity in pairs(self.targets) do
    local comp = entity.components.Asteroid
    goalX = comp.x + (comp.stepX * dt)
    goalY = comp.y + (comp.stepY * dt)
    local actualX, actualY, cols, len = world:move(entity, goalX, goalY)
    if len == 0 then
      comp.x = actualX
      comp.y = actualY
    else
      world:remove(entity)
      engine:removeEntity(entity)

      for k, col in pairs(cols) do
        -- TODO: Turn this back on, for asteroid on asteroid collision
        --world:remove(col.other)
        --engine:removeEntity(col.other)
      end
    end
  end
end

function AsteroidUpdateSystem:requires()
  return {'Asteroid'}
end

return AsteroidUpdateSystem
