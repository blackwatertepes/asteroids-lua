local Grenade = Component.create('Grenade')
local Object, Explosion = Component.load({'Object', 'Explosion'})

function Grenade:initialize(dist)
  self.dist = dist -- The distance from the origin at which to explode
end

function Grenade:explode(opts)
  local size = 20
  local x, y = opts.x + opts.width / 2 - size / 2, opts.y + opts.height / 2 - size / 2
  local theta, steps = 0, 8
  for i=theta, steps, 1 do
    local theta = math.pi*2 * i/steps
    local object = Object({x = x, y = y, width = size, height = size, vector = theta, speed = 100})
    createWorldEntity(object, {Explosion()})
  end
end
