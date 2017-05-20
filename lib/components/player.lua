local Player = Component.create('Player')
function Player:initialize()
  self.size = 40
  self.x = love.graphics.getWidth() / 2 - self.size / 2
  self.y = love.graphics.getHeight() / 2 - self.size / 2
  self.rotation = 0
  self.speedRot = 0
  self.lastFired = 0
  self.highlight = false
  self.anchorXY = nil
end

function Player:anchorToMouse()
  self.anchorXY = {x = love.mouse.getX(), y = love.mouse.getY()}
  self.rotation = lume.angle(self.anchorXY.x, self.anchorXY.y, self.x + self.size / 2, self.y + self.size / 2)
end

function Player:releaseFromMouse()
  self.anchorXY = nil
end

function Player:loaded()
  return self.anchorXY ~= nil
end

function Player:fire(bullet)
  self:releaseFromMouse()
  createWorldEntity({bullet})
end
