local Debris = Component.create('Debris')
function Debris:initialize(opts)
  local maxRot, distX, distY = 10, opts.bx - opts.ax, opts.by - opts.ay
  self.x = opts.x or opts.ax + distX / 2
  self.y = opts.y or opts.ay + distY / 2
  self.rot = math.atan2(distY, distX)
  self.size = math.sqrt(math.pow(distX, 2) + math.pow(distY, 2))
  self.vector = opts.vector
  self.speed = opts.speed
  self.stepRot = math.random() * maxRot - maxRot / 2
  self.stepX = self.speed * math.cos(self.vector)
  self.stepY = self.speed * math.sin(self.vector)
end
