local BulletUpdateSystem = class("BulletUpdateSystem", System)
local Bullet = Component.load({'Bullet'})

function BulletUpdateSystem:update(dt)
  local speed = 800
  for i, entity in pairs(self.targets) do
    local comp = entity.components.Bullet
    comp.x = comp.x + speed * math.cos(comp.angle) * dt
    comp.y = comp.y + speed * math.sin(comp.angle) * dt
  end
end

function BulletUpdateSystem:requires()
  return {'Bullet'}
end

return BulletUpdateSystem
