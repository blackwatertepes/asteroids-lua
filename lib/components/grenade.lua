local Grenade = Component.create('Grenade')
function Grenade:initialize(x, y, angle, dist)
  self.size = 10
  self.x = x - self.size / 2
  self.y = y - self.size / 2
  self.angle = angle
  self.dist = dist -- The distance from the origin at which to explode
  self.origin = {x = self.x, y = self.y}
end
