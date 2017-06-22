local GrenadeUpdateSystem = class("GrenadeUpdateSystem", System)
local Grenade, Asteroid = Component.load({'Grenade', 'Asteroid'})

function GrenadeUpdateSystem:update(dt)
  for i, entity in pairs(self.targets) do
    local object, comp = entity.components.Object, entity.components.Grenade
    -- Remove bullets that go off-screen
    if object.x < 0 or object.y < 0 or object.x > love.graphics.getWidth() or object.y > love.graphics.getHeight() then
      world:remove(entity)
      engine:removeEntity(entity)
    elseif lume.distance(object.x, object.y, object.origin.x, object.origin.y, false) > comp.dist then
      world:remove(entity)
      engine:removeEntity(entity)
      comp:explode(object)
    else
      goalX = object.x + object.speed * math.cos(object.vector) * dt
      goalY = object.y + object.speed * math.sin(object.vector) * dt
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
    end
  end
end

function GrenadeUpdateSystem:requires()
  return {'Grenade'}
end

return GrenadeUpdateSystem
