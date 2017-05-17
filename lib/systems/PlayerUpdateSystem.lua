local PlayerUpdateSystem = class("PlayerUpdateSystem", System)
local Bullet = Component.load({'Bullet'})

function PlayerUpdateSystem:update(dt)
  local maxRot, stepAcc, stepDeacc, ttf = .08, .04, .02, .2 -- ttf = time til fire
  for i, entity in pairs(self.targets) do
    local comp = entity.components.Player
    -- Calculate the increase of the rotation
    if (love.keyboard.isDown('a') or love.keyboard.isDown('left')) and comp.speedRot > -maxRot then
      comp.speedRot = comp.speedRot - stepAcc
    elseif (love.keyboard.isDown('d') or love.keyboard.isDown('right')) and comp.speedRot < maxRot then
      comp.speedRot = comp.speedRot + stepAcc
    end
    -- Rotate
    comp.rotation = comp.rotation + comp.speedRot
    -- Slow down the rotation
    if comp.speedRot > 0 + stepDeacc then
      comp.speedRot = comp.speedRot - stepDeacc
    elseif comp.speedRot < 0 - stepDeacc then
      comp.speedRot = comp.speedRot + stepDeacc
    else
      comp.speedRot = 0
    end
    -- Determine firing
    if love.keyboard.isDown('space') and love.timer.getTime() - comp.lastFired > ttf then
      createWorldEntity(Bullet(comp.x + comp.size / 2, comp.y + comp.size / 2, comp.rotation))
      comp.lastFired = love.timer.getTime()
    end

    local mouseDistToPlayer = math.sqrt(math.pow(love.mouse.getX() - (comp.x + comp.size / 2), 2) + math.pow(love.mouse.getY() - (comp.y + comp.size / 2), 2))
    if mouseDistToPlayer < comp.size * 2 then
      comp.highlight = true
      if love.mouse.isDown(1) then
        comp:anchorToMouse()
      end
    else
      comp.highlight = false
    end

    if comp:loaded() then
      if love.mouse.isDown(1) then
        comp:anchorToMouse()
      else
        comp:fire(Bullet(comp.x + comp.size / 2, comp.y + comp.size / 2, comp.rotation))
      end
    end
  end
end

function PlayerUpdateSystem:requires()
  return {'Player'}
end

return PlayerUpdateSystem