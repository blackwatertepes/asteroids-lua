local PlayerUpdateSystem = class("PlayerUpdateSystem", System)

function PlayerUpdateSystem:update(dt)
  local stepRot = .1
  for i, entity in pairs(self.targets) do
    local comp = player.components.Player
    if love.keyboard.isDown('a') or love.keyboard.isDown('left') then
      comp.rotation = comp.rotation - stepRot
    elseif love.keyboard.isDown('d') or love.keyboard.isDown('right') then
      comp.rotation = comp.rotation + stepRot
    end
  end
end

function PlayerUpdateSystem:requires()
  return {'Player'}
end

return PlayerUpdateSystem
