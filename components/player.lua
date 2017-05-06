local Player = Component.create('Player')
function Player:initialize()
  self.size = 40
  self.x = love.graphics.getWidth() / 2 - self.size / 2
  self.y = love.graphics.getHeight() / 2 - self.size / 2
  self.rotation = 0
  self.speedRot = 0
end
