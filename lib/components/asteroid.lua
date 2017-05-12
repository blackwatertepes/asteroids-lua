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
  local theta = self.rot
  local x = self.x + self.size / 2 + self.size / 2 * self.per * math.cos(theta) * self.rands[0]
  local y = self.y + self.size / 2 + self.size / 2 * self.per * math.sin(theta) * self.rands[1]
  local lastXY = {x = x, y = y}
  for i=1, #self.rands/2-1, 1 do
    local theta = self.rot + math.pi*2 * i/#self.rands*2
    local x = self.x + self.size / 2 + self.size / 2 * self.per * math.cos(theta) * self.rands[i*2]
    local y = self.y + self.size / 2 + self.size / 2 * self.per * math.sin(theta) * self.rands[i*2+1]
    local vector = math.random() * math.pi*2
    createEntity(Debris({ax = x, ay = y, bx = lastXY.x, by = lastXY.y, speed = 10, vector = vector}))
    lastXY.x = x
    lastXY.y = y
  end
  local vector = math.random() * math.pi*2
  local theta = self.rot
  local x = self.x + self.size / 2 + self.size / 2 * self.per * math.cos(theta) * self.rands[0]
  local y = self.y + self.size / 2 + self.size / 2 * self.per * math.sin(theta) * self.rands[1]
  createEntity(Debris({ax = x, ay = y, bx = lastXY.x, by = lastXY.y, speed = 10, vector = vector}))
end
