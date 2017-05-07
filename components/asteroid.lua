local Asteroid = Component.create('Asteroid')
function Asteroid:initialize(opts)
  local maxRot, complexity = 4, 20
  -- Generate a set of randos for drawing the poly
  self.rands = {}
  for i=0, complexity * 2, 1 do
    self.rands[i] = math.random(80, 100) / 100
  end
  self.size = opts.size
  self.x = opts.x
  self.y = opts.y
  self.vector = opts.vector
  self.speed = opts.speed
  self.rot = 0
  self.stepRot = math.random() * maxRot - maxRot / 2
  self.stepX = self.speed * math.cos(self.vector)
  self.stepY = self.speed * math.sin(self.vector)
end
