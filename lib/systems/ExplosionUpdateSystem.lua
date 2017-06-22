local ExplosionUpdateSystem = class("ExplosionUpdateSystem", System)
local Explosion, Asteroid = Component.load({'Explosion', 'Asteroid'})

function ExplosionUpdateSystem:update(dt)
  for i, entity in pairs(self.targets) do
    local object, comp = entity.components.Object, entity.components.Explosion
    comp.age = comp.age + dt
    if comp.age > comp.ttl then
      world:remove(entity)
      engine:removeEntity(entity)
    else
      local goalX = object.x + object.speed * math.cos(object.vector) * dt
      local goalY = object.y + object.speed * math.sin(object.vector) * dt
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

      for j, col in pairs(cols) do
        world:remove(col.other)
        engine:removeEntity(col.other)
        local obj, ast = col.other.components.Object, col.other.components.Asteroid
        ast:createDebris(obj)
        -- If it was a large asteroid, then create 2 smaller ones
        if obj.width > 50 then
          ast:createSmaller(obj)
        end
      end
    end
  end
end

function ExplosionUpdateSystem:requires()
  return {'Explosion'}
end

return ExplosionUpdateSystem
