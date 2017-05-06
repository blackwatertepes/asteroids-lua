local Asteroid = Component.create('Asteroid')
function Asteroid:initialize()
  self.dist = love.graphics.getWidth() * .7
  local maxRot, complexity = 4, 20
  -- Find a random starting location on a circle, with a pref for the left and right sides
  local distY = math.random(self.dist)
  if math.random() > .5 then distY = -distY end
  local distX = math.sqrt(math.pow(self.dist, 2) - math.pow(distY, 2))
  if math.random() > .5 then distX = -distX end
  -- Generate a set of randos for drawing the poly
  self.rands = {}
  for i=0, complexity * 2, 1 do
    self.rands[i] = math.random(80, 100) / 100
  end
  self.size = 80
  self.stepRot = math.random() * maxRot - maxRot / 2
  self.targetX = (love.graphics.getWidth() / 2 - self.size / 2) * math.random(50, 150) / 100
  self.targetY = (love.graphics.getHeight() / 2 - self.size / 2) * math.random(50, 150) / 100
  self.x = self.targetX + distX
  self.y = self.targetY + distY
  self.rot = 0
  self.eta = 8
  self.stepX = (self.targetX - self.x) / self.eta
  self.stepY = (self.targetY - self.y) / self.eta
end
