local GrenadeUpdateSystem = class("GrenadeUpdateSystem", System)
local Grenade, Asteroid = Component.load({'Grenade', 'Asteroid'})

function GrenadeUpdateSystem:update(dt)
  local speed = 500
  for i, entity in pairs(self.targets) do
    local comp = entity.components.Grenade
    -- Remove bullets that go off-screen
    if comp.x < 0 or comp.y < 0 or comp.x > love.graphics.getWidth() or comp.y > love.graphics.getHeight() then
      world:remove(entity)
      engine:removeEntity(entity)
    elseif lume.distance(comp.x, comp.y, comp.origin.x, comp.origin.y, false) > comp.dist then
      world:remove(entity)
      engine:removeEntity(entity)
      -- TODO: Create an explosion
    else
      goalX = comp.x + speed * math.cos(comp.angle) * dt
      goalY = comp.y + speed * math.sin(comp.angle) * dt
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
    end
  end
end

function GrenadeUpdateSystem:requires()
  return {'Grenade'}
end

return GrenadeUpdateSystem
