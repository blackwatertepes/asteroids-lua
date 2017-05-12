local Debris = Component.load({'Debris'})

local Asteroid = Component.create('Asteroid')
function Asteroid:initialize(opts)
  local maxRot, complexity = 4, 20
  -- Generate a set of randos for drawing the poly
  self.per = 1.2 -- percentage to bounding box
  self.rands = {}
  for i=0, complexity * 2, 1 do
    self.rands[i] = math.random(90, 110) / 100
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

function Asteroid:createDebris()
  local x = self.x + self.size / 2 + self.size / 2 * self.per
  local y = self.y + self.size / 2
  local lastXY = {x = x, y = y}
  for i=1, #self.rands/2-1, 1 do
    local theta = math.pi*2 * i/#self.rands*2
    local x = self.x + self.size / 2 + self.size / 2 * self.per * math.cos(theta)
    local y = self.y + self.size / 2 + self.size / 2 * self.per * math.sin(theta)
    local vector = math.random() * math.pi*2
    createEntity(Debris({ax = x, ay = y, bx = lastXY.x, by = lastXY.y, speed = 40, vector = vector}))
    lastXY.x = x
    lastXY.y = y
  end
  local vector = math.random() * math.pi*2
  local x = self.x + self.size / 2 + self.size / 2 * self.per
  local y = self.y + self.size / 2
  createEntity(Debris({ax = x, ay = y, bx = lastXY.x, by = lastXY.y, speed = 40, vector = vector}))
end

function Asteroid:createSmaller()
  local size, speed = self.size / 2 * math.random(50, 150) / 100, self.speed
  local vectorA, vectorB = self.vector + math.pi/2, self.vector - math.pi/2
  local ax, ay = self.x + math.cos(vectorA) * size * .8, self.y + math.sin(vectorA) * size * .8
  local bx, by = self.x + math.cos(vectorB) * size * .8, self.y + math.sin(vectorB) * size * .8
  createWorldEntity(Asteroid({size = size, x = ax, y = ay, speed = speed, vector = self.vector + math.random()}))
  createWorldEntity(Asteroid({size = size, x = bx, y = by, speed = speed, vector = self.vector - math.random()}))
end
