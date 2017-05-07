local DebrisUpdateSystem = class('DebrisUpdateSystem', System)

function DebrisUpdateSystem:update(dt)
  for i, entity in pairs(self.targets) do
    local comp = entity.components.Debris
    -- Remove Debris that is offscreen
    if math.sqrt(math.pow(comp.x, 2) + math.pow(comp.y, 2)) > love.graphics.getWidth() * 2 then
      engine:removeEntity(entity)
    else
      comp.rot = comp.rot + (comp.stepRot * dt)
      comp.x = comp.x + (comp.stepX * dt)
      comp.y = comp.y + (comp.stepY * dt)
    end
  end
end

function DebrisUpdateSystem:requires()
  return {'Debris'}
end

return DebrisUpdateSystem
