local Bullet = Component.create('Bullet')
function Bullet:initialize(x, y, angle)
  self.size = 2
  self.x = x - self.size / 2
  self.y = y - self.size / 2
  self.angle = angle
end
