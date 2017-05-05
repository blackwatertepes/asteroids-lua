local Asteroid = Component.create('Asteroid')
function Asteroid:initialize()
  local dist = love.graphics.getWidth() * .7
  local distY = math.random(dist)
  if math.random() > .5 then distY = -distY end
  local distX = math.sqrt(math.pow(dist, 2) - math.pow(distY, 2))
  if math.random() > .5 then distX = -distX end

  self.size = 20
  self.stepRot = math.random() * 2 - 1
  self.targetX = love.graphics.getWidth() / 2 - self.size / 2
  self.targetY = love.graphics.getHeight() / 2 - self.size / 2
  self.x = self.targetX + distX
  self.y = self.targetY + distY
  self.rot = 0
  self.eta = 4
  self.stepX = (self.targetX - self.x) / self.eta
  self.stepY = (self.targetY - self.y) / self.eta
end
