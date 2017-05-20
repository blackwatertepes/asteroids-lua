local ObjectUpdateSystem = class('ObjectUpdateSystem', System)

function ObjectUpdateSystem:update(dt)
  for i, entity in pairs(self.targets) do
    local object = entity.components.Object
    object:update(dt)
    object:remove(entity)
  end
end

function ObjectUpdateSystem:requires()
  return {'Object'}
end

return ObjectUpdateSystem
