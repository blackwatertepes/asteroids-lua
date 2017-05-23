local Debris, Object = Component.load({'Debris', 'Object'})

local Asteroid = Component.create('Asteroid')
function Asteroid:initialize(opts)
  local complexity = 20
  -- Generate a set of randos for drawing the poly
  self.per = 1.2 -- percentage to bounding box
  self.rands = {}
  for i=0, complexity * 2, 1 do
    self.rands[i] = math.random(90, 110) / 100
  end
end

function Asteroid:createDebris(opts)
  local x = opts.x + opts.width / 2 + opts.width / 2 * self.per
  local y = opts.y + opts.height / 2
  local lastXY = {x = x, y = y}
  for i=1, #self.rands/2-1, 1 do
    local theta = math.pi*2 * i/#self.rands*2
    local x = opts.x + opts.width / 2 + opts.width / 2 * self.per * math.cos(theta)
    local y = opts.y + opts.height / 2 + opts.height / 2 * self.per * math.sin(theta)
    createDebris(x, y, lastXY.x, lastXY.y)
    lastXY.x = x
    lastXY.y = y
  end
  local x = opts.x + opts.width / 2 + opts.width / 2 * self.per
  local y = opts.y + opts.height / 2
  createDebris(x, y, lastXY.x, lastXY.y)
end

function Asteroid:createSmaller(opts)
  local size, speed = opts.width / 2 * math.random(50, 150) / 100, opts.speed
  local vectorA, vectorB = opts.vector + math.pi/2, opts.vector - math.pi/2
  local ax, ay = opts.x + math.cos(vectorA) * size * .8, opts.y + math.sin(vectorA) * size * .8
  local bx, by = opts.x + math.cos(vectorB) * size * .8, opts.y + math.sin(vectorB) * size * .8
  createAsteroid({x = ax, y = ay, speed = speed, vector = opts.vector + math.random(), size = size})
  createAsteroid({x = bx, y = by, speed = speed, vector = opts.vector - math.random(), size = size})
end
