local Debris = Component.create('Debris')
function Debris:initialize(opts)
  local maxRot = 10
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
