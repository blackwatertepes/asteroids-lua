local AsteroidUpdateSystem = class('AsteroidUpdateSystem', System)

function AsteroidUpdateSystem:update()
  for i, entity in pairs(self.targets) do
    local goalX = entity.components.Asteroid.x + entity.components.Asteroid.velocityX
    local goalY = entity.components.Asteroid.y + entity.components.Asteroid.velocityY
    local actualX, actualY, cols, len = world:move(entity, goalX, goalY)
    if len == 0 then
      entity.components.Asteroid.x = actualX
      entity.components.Asteroid.y = actualY
    else
      world:remove(entity)
      engine:removeEntity(entity)
    end
  end
end

function AsteroidUpdateSystem:requires()
  return {'Asteroid'}
end

return AsteroidUpdateSystem
