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
  -- TODO: Figure out how to do 'unless'
  if self.anchorXY == nil then
    self.anchorXY = {x = love.mouse.getX(), y = love.mouse.getY()}
  else
    self.anchorXY = {x = love.mouse.getX(), y = love.mouse.getY()}
    -- TODO: Figure out rotation
    --self.rotation = math.atan2(self.anchorXY.y, self.anchorXY.x) / math.pi*2 * 360
    --self.rotation = lume.angle(self.anchorXY.x, self.anchorXY.y, 0, 0)
  end
end

function Player:releaseFromMouse()
  self.anchorXY = nil
end
