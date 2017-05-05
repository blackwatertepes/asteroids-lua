local AsteroidUpdateSystem = class('AsteroidUpdateSystem', System)

function AsteroidUpdateSystem:update()
  for i, entity in pairs(self.targets) do
    local goalX = entity.components.Ast.x + entity.components.Ast.velocityX
    local goalY = entity.components.Ast.y + entity.components.Ast.velocityY
    local actualX, actualY, cols, len = world:move(entity.components.Ast, goalX, goalY)
    if len == 0 then
      entity.components.Ast.x = actualX
      entity.components.Ast.y = actualY
    else
      world:remove(entity.components.Ast)
      engine:removeEntity(entity)
    end
  end
end

function AsteroidUpdateSystem:requires()
  return {'Ast'}
end

return AsteroidUpdateSystem
