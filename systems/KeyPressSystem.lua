local KeyPressSystem = class("KeyPressSystem", System)

function KeyPressSystem:fireEvent(event)
  --print('key pressed:', event.key)
  local stepRot = .2
  local player = engine:getEntitiesWithComponent('Player')[1]
  local comp = player.components.Player
  if event.key == 'a' or event.key == 'left' then
    comp.rotation = comp.rotation - stepRot
  elseif event.key == 'd' or event.key == 'right' then
    comp.rotation = comp.rotation + stepRot
  end
end

return KeyPressSystem
