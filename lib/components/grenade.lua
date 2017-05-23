local Grenade = Component.create('Grenade')
function Grenade:initialize(dist)
  self.dist = dist -- The distance from the origin at which to explode
end
