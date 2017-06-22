local PlayerUpdateSystem = class("PlayerUpdateSystem", System)
local Object = Component.load({'Object'})

function PlayerUpdateSystem:update(dt)
  local maxRot, stepAcc, stepDeacc, ttf = .08, .04, .02, .5 -- ttf = time til fire
  for i, entity in pairs(self.targets) do
    local object, comp = entity.components.Object, entity.components.Player
    local x, y, rotation, size, speedRot = object.x, object.y, object.rotation, object.width, object.stepRot
    -- Calculate the increase of the rotation
    if (love.keyboard.isDown('a') or love.keyboard.isDown('left')) and speedRot > -maxRot then
      object.rotation = rotation - stepAcc
    elseif (love.keyboard.isDown('d') or love.keyboard.isDown('right')) and speedRot < maxRot then
      object.rotation = rotation + stepAcc
    end

    -- TODO: Remove this eventually, this is just for dev
    if love.timer.getTime() - comp.lastFired > ttf then
      if love.keyboard.isDown('space') then
        comp:fireBullet(object)
      end

      if love.keyboard.isDown('1') then
        comp:fireGrenade(100, object)
      end

      if love.keyboard.isDown('2') then
        comp:fireGrenade(200, object)
      end
    end

    local mouseDistToPlayer = math.sqrt(math.pow(love.mouse.getX() - (x + size / 2), 2) + math.pow(love.mouse.getY() - (y + size / 2), 2))
    if mouseDistToPlayer < size * 2 then
      comp.highlight = true
      if love.mouse.isDown(1) then
        comp:anchorToMouse(object)
      end
    else
      comp.highlight = false
    end

    if comp:loaded() then
      if love.mouse.isDown(1) then
        comp:anchorToMouse(object)
      else
        comp:fireGrenade(mouseDistToPlayer * 2, object)
      end
    end
  end
end

function PlayerUpdateSystem:requires()
  return {'Player'}
end

return PlayerUpdateSystem
